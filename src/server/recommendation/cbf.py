import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

pd.set_option('display.max_rows', 100)  # 행을 최대 100개까지 출력
pd.set_option('display.max_columns', 100)  # 열을 최대 100개 까지 출력
pd.set_option('display.width', 1000)  # 출력 창 넓이 설정

r_cols = ['id', 'name', 'brand', 'category', 'gender', 'color']
products = pd.read_csv("data/cream/products.csv", sep=",", names=r_cols, encoding='latin-1')

count_vector = CountVectorizer(ngram_range=(1, 1))
c_vector_name = count_vector.fit_transform(products['name'])
name_c_sim = cosine_similarity(c_vector_name, c_vector_name).argsort()[:, ::-1]


def get_recommend_product_list(idx, n_items=30):
    product = products[products['id'] == idx]
    target_product_index = product.index.values

    sim_index = name_c_sim[target_product_index, :n_items].reshape(-1)

    cate, gender = product.category.values[0], product.gender.values[0]
    result = products.iloc[sim_index]
    result = result[(result['category'] == cate) & (result['gender'] == gender)]
    return result


print(get_recommend_product_list(products, 635))
