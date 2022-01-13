package com.cream.gateway.error

enum class ErrorCode(status:Int, err: Int, message: String) {
    // Common
    INVALID_INPUT_VALUE(400,-1, "Invalid Input value"),
    METHOD_NOT_ALLOWED(405, -2, "Invalid Http method"),
    ENTITY_NOT_FOUND(400, -3, "Entity Not Found"),

    INTERNAL_SERVER_ERROR(500, -99, "Server Error"),

    // GATEWAY FILTER - TOKEN
    USER_TOKEN_NOT_VALID(400, -16, "token is not valid"),
    USER_TOKEN_EXPIRED(400, -21, "token is expired"),
    USER_TOKEN_EMPTY(404, -22, "token is empty")
    ;

    val status: Int = status
    var errCode: Int = err
    var message: String = message
}