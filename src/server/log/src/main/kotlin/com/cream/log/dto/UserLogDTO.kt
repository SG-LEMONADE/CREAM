package com.cream.log.dto

import com.cream.log.model.UserLog

data class UserLogDTO(
    val userId: Long,
    val productId: Long,
    val action: Int
) {
    fun toEntity(): UserLog {
        return UserLog(userId = userId, productId = productId, action = action)
    }
}