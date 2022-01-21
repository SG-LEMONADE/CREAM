package com.cream.user.dto

data class TokenDTO(
    val userId: Long?,
    val accessToken: String,
    val refreshToken: String
)