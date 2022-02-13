package com.cream.product.dto

data class UserLogDTO(
    val userId: Long,
    val productId: Long,
    val action: Int
)