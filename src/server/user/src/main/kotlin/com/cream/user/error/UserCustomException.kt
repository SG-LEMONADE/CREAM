package com.cream.user.error

class UserCustomException : RuntimeException {
    var errorCode: ErrorCode
    constructor(errorCode: ErrorCode) : super(errorCode.message) {
        this.errorCode = errorCode
    }
}