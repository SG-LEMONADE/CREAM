package com.cream.product.dto.tradeDTO

import com.cream.product.constant.TradeStatus
import com.fasterxml.jackson.annotation.JsonRawValue
import com.querydsl.core.annotations.QueryProjection
import java.time.LocalDateTime

data class TradeHistoryDTO @QueryProjection constructor(
    val id: Long,
    val name: String,
    val size: String,
    @JsonRawValue val imageUrl: String,
    val backgroundColor: String,
    val tradeStatus: TradeStatus,
    val updateDateTime: LocalDateTime?,
    val validationDate: LocalDateTime
)