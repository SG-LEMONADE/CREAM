package com.cream.product.error

enum class ErrorCode(
    val status: Int,
    val errCode: Int,
    val message: String
) {

    // Common
    INVALID_INPUT_VALUE(400, -1, "Invalid Input value"),
    METHOD_NOT_ALLOWED(405, -2, "Invalid Http method"),
    ENTITY_NOT_FOUND(400, -3, "Entity Not Found"),

    INTERNAL_SERVER_ERROR(500, -99, "Server Error")
    ;
}