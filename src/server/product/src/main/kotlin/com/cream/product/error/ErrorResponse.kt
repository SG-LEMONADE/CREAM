package com.cream.product.error


class ErrorResponse(errorCode: ErrorCode){
    val status: Int = errorCode.status
    val code: Int = errorCode.errCode
    val message: String = errorCode.message
}