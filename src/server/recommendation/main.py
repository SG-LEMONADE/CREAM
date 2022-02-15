import numpy as np
import pandas as pd
import schedule as schedule
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

from pymongo import MongoClient

host = "localhost"
port = 27017
mongo = MongoClient(host, port)


def cf_knn(df, user_sim, user_id, product_id, neighbor_size=0):
    # cf 알고리즘을 위한 유저별 유사도 계산
    if product_id in df:
        sim_scores = user_sim[user_id].copy()
        product_ratings = df[product_id].copy()
        non_clicked_products = product_ratings[product_ratings.isnull()].index
        product_ratings = product_ratings.dropna()
        sim_scores = sim_scores.drop(non_clicked_products)

        if sim_scores.sum() != 0 or neighbor_size == 0:
            mean_rating = np.dot(sim_scores, product_ratings) / sim_scores.sum()
        else:
            if len(sim_scores) > 1:
                neighbor_size = min(neighbor_size, len(sim_scores))
                sim_scores = np.array(sim_scores)
                product_ratings = np.array(product_ratings)

                user_idx = np.argsort(sim_scores)
                sim_scores = sim_scores[user_idx][-neighbor_size:]
                product_ratings = product_ratings[user_idx][-neighbor_size:]
                if sim_scores.sum() != 0:
                    mean_rating = np.dot(sim_scores, product_ratings) / sim_scores.sum()
                else:
                    mean_rating = 0
            else:
                mean_rating = 0
    else:
        mean_rating = 0
    return mean_rating


def cf_recommend_product(df, user_sim, user_id, n_items, neighbor_size=30):
    user_product = df.loc[user_id].copy()
    for product in df:
        user_product.loc[product] = cf_knn(df, user_sim, user_id, product, neighbor_size)
    result = user_product.sort_values(ascending=False)[:n_items]
    result = result.index.to_list()
    result = list(map(str, result))
    return result


def cbf_recommend_product(df, name_sim, idx, n_items=30):
    product = df[df['id'] == str(idx)]
    target_product_index = product.index.values

    sim_index = name_sim[target_product_index, :n_items].reshape(-1)

    cate, gender = product.category.values[0], product.gender.values[0]
    result = df.iloc[sim_index]
    result = result[(result['category'] == cate) & (result['gender'] == gender)]
    result = result['id'].to_list()
    return result


def get_rating_df():
    result = mongo['log']['userLog'].find(None, {"_id": False, "_class": False, "createdAt": False})
    ratings = pd.DataFrame(list(result))
    return ratings


def get_product_df():
    result = mongo['log']['product'].find(None, {"_id": False})
    products = pd.DataFrame(list(result))
    return products


def main(log_sum_pivot, least_sum_pivot, n_items):
    # cf를 위한 유저 별 유사도 계산 (코사인 유사도)
    ratings = get_rating_df()
    ratings_by_user_product = ratings.groupby(['userId', 'productId'])['action'].sum().reset_index()
    rating_matrix = ratings_by_user_product.pivot(index='userId', columns='productId', values='action')
    matrix_copied = rating_matrix.copy().fillna(0)
    user_similarity = cosine_similarity(matrix_copied, matrix_copied)
    user_similarity = pd.DataFrame(user_similarity, index=rating_matrix.index, columns=rating_matrix.index)

    # cbf를 위한 상품 유사도 계산 (코사인 유사도)
    products = get_product_df()
    count_vector = CountVectorizer(ngram_range=(1, 1))
    c_vector_name = count_vector.fit_transform(products['name'])
    name_c_sim = cosine_similarity(c_vector_name, c_vector_name).argsort()[:, ::-1]

    ratings_by_products = ratings.groupby(['productId']).sum().sort_values('action', ascending=False)

    print("--------------- start calculation ---------------")
    # 분기 태우기 만약 user 의 활동이 충분하지 않다면 CBF, 아니라면 CF
    total_user_log_count = ratings_by_user_product.groupby(['userId'])['action'].sum()
    for user_idx, data_cnt in enumerate(total_user_log_count):
        if (user_idx + 1) % 100 == 0:
            print(user_idx+1)
        data = {}
        if data_cnt >= log_sum_pivot:
            data["recommendedItems"] = cf_recommend_product(rating_matrix, user_similarity,
                                                             user_idx + 1, n_items, 71)
        elif data_cnt > least_sum_pivot:
            cbf_product_list = []
            curr_user_log = ratings_by_user_product[ratings_by_user_product['userId'] == user_idx + 1] \
                .sort_values('action', ascending=False)
            for user, product_id, score in curr_user_log.values:
                score_proportion = int((score / data_cnt) * n_items)
                cbf_product_list.extend(cbf_recommend_product(products, name_c_sim, product_id, score_proportion))
            data["recommendedItems"] = cbf_product_list

        else:
            cold_user_product_list = []
            best_item_num, new_item_num = int(0.75 * n_items), int(0.25 * n_items)
            cold_user_product_list.extend(ratings_by_products[:best_item_num].index.to_list())
            cold_user_product_list.extend(ratings_by_products[-new_item_num:].index.to_list())
            data["recommendedItems"] = cold_user_product_list
        mongo['log']['recommendItem'].find_one_and_update({'userId': user_idx + 1},
                                                          {"$set": data},
                                                          upsert=True)
    print("--------------- finished ! ---------------")


if __name__ == '__main__':
    schedule.every(3).hours.do(main(50, 15, 30))
    while True:
        schedule.run_pending()
