package com.cream.user.error

class UserCustomException(var errorCode: ErrorCode) : RuntimeException(errorCode.message)