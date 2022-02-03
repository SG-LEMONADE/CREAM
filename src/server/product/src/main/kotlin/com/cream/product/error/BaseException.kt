package com.cream.product.error

open class BaseException(
    val code: ErrorCode,
) : RuntimeException()