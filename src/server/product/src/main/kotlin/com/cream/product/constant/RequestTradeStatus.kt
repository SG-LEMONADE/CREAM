package com.cream.product.constant

enum class RequestTradeStatus(
    val value: Int
) {
    ALL(0),
    WAITING(1),
    IN_PROGRESS(2),
    FINISHED(3)
}