package com.cream.product.dto

import com.cream.product.constant.RequestType

class ProductPriceByRequestTypeDTO(
    val requestType: RequestType,
    val price: Int
)