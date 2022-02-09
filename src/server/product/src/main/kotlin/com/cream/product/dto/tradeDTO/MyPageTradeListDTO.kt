package com.cream.product.dto.tradeDTO

data class MyPageTradeListDTO(
    val counter: TradeHistoryCounterDTO,
    val trades: List<TradeHistoryDTO>
)