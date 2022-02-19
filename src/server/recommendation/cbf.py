import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity


r_cols = ['id', 'name', 'brand', 'category', 'gender', 'color']
products = pd.read_csv("data/cream/products.csv", sep=",", names=r_cols, encoding='latin-1')

# 상품의 이름을 하나의 절로 나누어 각각의 유사성을 코사인 유사도를 통해 구합니다.
count_vector = CountVectorizer(ngram_range=(1, 1))
c_vector_name = count_vector.fit_transform(products['name'])
# 이후 점수 별로 정렬합니다.
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
