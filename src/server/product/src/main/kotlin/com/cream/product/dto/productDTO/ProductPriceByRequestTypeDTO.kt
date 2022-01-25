package com.cream.product.dto.productDTO

import com.cream.product.constant.RequestType

class ProductPriceByRequestTypeDTO(
    val requestType: RequestType?,
    val price: Int?
)