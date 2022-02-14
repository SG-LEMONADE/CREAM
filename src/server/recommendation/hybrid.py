import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity


# user 별 추천 아이템을 mongodb에 저장할 수 있게 합니다.

def cf_knn(user_id, product_id, neighbor_size=0):
    if product_id in rating_matrix:
        sim_scores = user_similarity[user_id].copy()
        product_ratings = rating_matrix[product_id].copy()
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


def cf_recommend_product(user_id, n_items, neighbor_size=30):
    user_product = rating_matrix.loc[user_id].copy()
    for product in rating_matrix:
        user_product.loc[product] = cf_knn(user_id, product, neighbor_size)
    product_sort = user_product.sort_values(ascending=False)[:n_items]
    return product_sort


def cbf_recommend_product(idx, n_items=30):
    product = products[products['id'] == idx]
    target_product_index = product.index.values

    sim_index = name_c_sim[target_product_index, :n_items].reshape(-1)

    cate, gender = product.category.values[0], product.gender.values[0]
    result = products.iloc[sim_index]
    result = result[(result['category'] == cate) & (result['gender'] == gender)]
    return result


log_sum_pivot = 50
n_items = 30

cf_r_cols = ['userId', 'productId', 'action', 'createdAt']
ratings = pd.read_csv("data/cream/userLog.csv", sep=",", names=cf_r_cols, encoding='latin-1')
ratings = ratings.drop('createdAt', axis=1)
ratings_by_products = ratings.groupby(['productId']).sum().sort_values('action', ascending=False)
ratings = ratings.groupby(['userId', 'productId'])['action'].sum().reset_index()

rating_matrix = ratings.pivot(index='userId', columns='productId', values='action')
matrix_copied = rating_matrix.copy().fillna(0)
user_similarity = cosine_similarity(matrix_copied, matrix_copied)
user_similarity = pd.DataFrame(user_similarity, index=rating_matrix.index, columns=rating_matrix.index)

cbf_r_cols = ['id', 'name', 'brand', 'category', 'gender', 'color']
products = pd.read_csv("data/cream/products.csv", sep=",", names=cbf_r_cols, encoding='latin-1')

count_vector = CountVectorizer(ngram_range=(1, 1))
c_vector_name = count_vector.fit_transform(products['name'])
name_c_sim = cosine_similarity(c_vector_name, c_vector_name).argsort()[:, ::-1]

# 분기 태우기 만약 user 의 활동이 충분하지 않다면 CBF, 아니라면 CF
total_user_log_count = ratings.groupby(['userId'])['action'].sum()

total_result = {}
for user_idx, data_cnt in enumerate(total_user_log_count):
    if data_cnt >= log_sum_pivot:
        total_result[user_idx + 1] = cf_recommend_product(user_idx, n_items, 71)
    elif data_cnt > 0:
        cbf_product_list = []
        curr_user_log = ratings[ratings['userId'] == user_idx + 1].sort_values('action', ascending=False)
        for user, product_id, score in curr_user_log.values:
            score_proportion = int((score / data_cnt) * n_items)
            cbf_product_list.extend(cbf_recommend_product(product_id, score_proportion))
        total_result[user_idx + 1] = cbf_product_list
    else:
        cold_user_product_list = []
        best_item_num, new_items = int(0.75 * n_items), int(0.25 * n_items)
        cold_user_product_list.extend(ratings_by_products[:best_item_num].index)
        cold_user_product_list.extend(ratings_by_products[-new_items:].index)
        total_result[user_idx + 1] = cold_user_product_list
print(total_result)