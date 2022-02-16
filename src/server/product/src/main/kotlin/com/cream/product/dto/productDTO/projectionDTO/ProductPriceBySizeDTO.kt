package com.cream.product.dto.productDTO.projectionDTO

import com.querydsl.core.annotations.QueryProjection

data class ProductPriceBySizeDTO @QueryProjection constructor(
    val size: String,
    val lowestAsk: Int
)