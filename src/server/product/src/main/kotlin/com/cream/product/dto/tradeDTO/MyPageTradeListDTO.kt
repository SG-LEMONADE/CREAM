package com.cream.product.dto.tradeDTO

import com.cream.product.dto.tradeDTO.projectionDTO.TradeHistoryDTO

data class MyPageTradeListDTO(
    val counter: TradeHistoryCounterDTO,
    val trades: List<TradeHistoryDTO>
)