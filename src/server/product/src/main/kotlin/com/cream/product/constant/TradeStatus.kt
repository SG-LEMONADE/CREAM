package com.cream.product.constant

enum class TradeStatus(
    val value: Int
) {
    WAITING(0),
    IN_PROGRESS(1),
    COMPLETED(2),
    EXPIRED(3),
    CANCELED(4)
}