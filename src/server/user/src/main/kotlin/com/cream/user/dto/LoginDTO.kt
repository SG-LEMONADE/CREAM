package com.cream.user.dto

data class LoginDTO (
    val token: String = "",
    val email: String,
    val password: String
)