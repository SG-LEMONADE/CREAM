import json
import random

import requests

LOG_URL = 'http://localhost:8082/log'
PRODUCT_URL = 'http://localhost:8081/products/test'
wish_pos = [1, 9]
buy_pos = [1, 30]

print("start | ")

for user_num in range(1, 3001):

    cate = random.choices(["streetwear", "sneakers", "life", "electronics", "accessories"],
                          [76, 629, 361, 154, 356])[0]
    gender = None
    if cate == "sneakers":
        gender = random.choices(["men", "women", "kids"], [450, 116, 59])[0]
        cate_brands = [1, 2, 3, 4]
        b_w = [344, 219, 34, 68]
    elif cate == "life":
        gender = "life"
        cate_brands = [18, 19, 20, 21, 22]
        b_w = [95, 178, 85, 49, 29]
    elif cate == "streetwear":
        gender = random.choices(["streetwear_unisex", "streetwear_men"], [49, 27])[0]
        cate_brands = [23, 25]
        b_w = [44, 23]
    elif cate == "electronics":
        gender = "electronics"
        cate_brands = [38, 40, 41]
        b_w = [24, 22, 23]
    else:
        # accessories
        gender = "streetwear_unisex"
        cate_brands = [66, 68]
        b_w = [35, 55]

    cb = random.choices(cate_brands, b_w)[0]
    total_brands = [1, 2, 3, 4, 18, 19, 20, 21, 22, 23, 25, 38, 40, 41, 66, 68]
    weights = [344, 219, 34, 68, 95, 178, 85, 49, 29, 44, 23, 24, 22, 23, 35, 55]

    str_brands = ",".join(map(str, total_brands))
    if 1 <= user_num <= 900:
        products = requests.get(PRODUCT_URL + '?brands=' + str_brands)
        r = random.randrange(10, 40)

    elif 901 <= user_num <= 1800:
        products = requests.get(PRODUCT_URL + '?category=' + cate + "&gender=" +
                                gender + "&brands=" + str_brands)
        r = random.randrange(50, 120)
    else:
        products = requests.get(PRODUCT_URL + '?category=' + cate + "&gender=" +
                                gender + "&brands=" + str(cb))
        r = random.randrange(30, 50)

    val = json.loads(products.text)

    if user_num >= 1801:
        val = random.choices(val, k=random.randrange(1, 10))
        wish_pos = [1, 4]
        buy_pos = [1, 10]

    for _ in range(r):
        product_num = random.choice(val)
        requests.post(LOG_URL, json={"userId": user_num, "productId": product_num, "action": 1})
        is_wish = random.choices([True, False], wish_pos)
        is_buy = random.choices([True, False], buy_pos)
        if is_wish[0]:
            requests.post(LOG_URL, json={"userId": user_num, "productId": product_num, "action": 2})
        if is_buy[0]:
            requests.post(LOG_URL, json={"userId": user_num, "productId": product_num, "action": 3})

    # 진행도를 나타내는 프로그레스 바
    if user_num % 300 == 0:
        print("-", end='')

print(" | finished!")