package com.cream.user.dto

data class ResponseDTO<T>(
    val err: Int,
    val data: Any?
        )