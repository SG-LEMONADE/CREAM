package com.cream.user.dto

data class RefreshTokenDTO (
    val userId: Long?,
    val refreshToken: String
)