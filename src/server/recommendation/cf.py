import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics.pairwise import cosine_similarity


def RMSE(y_true, y_pred):
    return np.sqrt(np.mean((np.array(y_true) - np.array(y_pred)) ** 2))


def score(model, neighbor_size=0):
    # RMSE를 계산하기 위한
    id_pairs = zip(x_test['userId'], x_test['productId'])
    y_pred = np.array([model(user, movie, neighbor_size) for (user, movie) in id_pairs])
    y_true = np.array(x_test['action'])
    return RMSE(y_true, y_pred)


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


def recommend_product(user_id, n_items, neighbor_size=30):
    user_product = rating_matrix.loc[user_id].copy()
    for product in rating_matrix:
        user_product.loc[product] = cf_knn(user_id, product, neighbor_size)
    product_sort = user_product.sort_values(ascending=False)[:n_items]
    return product_sort


r_cols = ['userId', 'productId', 'action', 'createdAt']
ratings = pd.read_csv("data/cream/userLog.csv", sep=",", names=r_cols, encoding='latin-1')
ratings = ratings.drop('createdAt', axis=1)

x = ratings.copy()
y = ratings['userId']
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.25, stratify=y)
x_train = x_train.groupby(['userId', 'productId'])['action'].sum().reset_index()

rating_matrix = x_train.pivot(index='userId', columns='productId', values='action')
matrix_copied = rating_matrix.copy().fillna(0)
user_similarity = cosine_similarity(matrix_copied, matrix_copied)
user_similarity = pd.DataFrame(user_similarity, index=rating_matrix.index, columns=rating_matrix.index)

print(score(cf_knn, 71))

# 70 - 3.16
# 71 - 3.13
# 72 - 3.14

print(recommend_product(1233, 30, 71))
