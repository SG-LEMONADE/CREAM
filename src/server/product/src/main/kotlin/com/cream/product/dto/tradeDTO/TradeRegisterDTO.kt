package com.cream.product.dto.tradeDTO

import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import com.cream.product.model.Product
import com.cream.product.model.Trade
import java.time.LocalDateTime

data class TradeRegisterDTO(
    val requestType: RequestType,
    val price: Int,
    val validationDay: Long
) {
    fun toEntity(userId: Long, product: Product, size: String): Trade {
        return Trade(
            userId = userId,
            product = product,
            size = size,
            requestType = if (this.requestType == RequestType.ASK) RequestType.BID else RequestType.ASK,
            tradeStatus = TradeStatus.WAITING,
            price = this.price,
            validationDateTime = LocalDateTime.now().plusDays(this.validationDay)
        )
    }
}