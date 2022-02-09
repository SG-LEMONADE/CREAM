package com.cream.product.dto.tradeDTO

data class TradeHistoryCounterDTO(
    val totalCnt: Int,
    val waitingCnt: Int,
    val inProgressCnt: Int,
    val finishedCnt: Int
)