package com.cream.gateway.dto

data class ResponseDTO<T>(
    val err: Int,
    val data: List<Any>?
        )