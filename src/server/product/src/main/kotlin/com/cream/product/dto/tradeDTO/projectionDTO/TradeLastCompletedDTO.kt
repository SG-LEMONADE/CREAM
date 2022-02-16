package com.cream.product.dto.tradeDTO.projectionDTO

import com.querydsl.core.annotations.QueryProjection
import java.time.LocalDateTime

data class TradeLastCompletedDTO @QueryProjection constructor(
    val size: String,
    val price: Int,
    val tradeDate: LocalDateTime?
)