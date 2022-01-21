package com.cream.product.error

open class BaseException (
    val code: ErrorCode,
    override val message: String?
    ) : RuntimeException()