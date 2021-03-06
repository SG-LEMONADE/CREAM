package com.cream.product.dto.tradeDTO.projectionDTO

import com.cream.product.constant.TradeStatus
import com.querydsl.core.annotations.QueryProjection

data class TradeStatusCounterDTO @QueryProjection constructor (
    val tradeStatus: TradeStatus,
    val counter: Long
)