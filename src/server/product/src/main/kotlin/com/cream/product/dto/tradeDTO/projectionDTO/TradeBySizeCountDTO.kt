package com.cream.product.dto.tradeDTO.projectionDTO

import com.querydsl.core.annotations.QueryProjection

data class TradeBySizeCountDTO @QueryProjection constructor(
    val size: String?,
    val price: Int?,
    val count: Long?
)