package com.cream.product.error

enum class ErrorCode(
    val status: Int,
    val errCode: Int,
    val message: String
) {

    // Common
    INVALID_INPUT_VALUE(400, -1, "Invalid Input value"),
    METHOD_NOT_ALLOWED(405, -2, "Invalid Http method"),
    ENTITY_NOT_FOUND(404, -3, "Entity Not Found"),

    INTERNAL_SERVER_ERROR(500, -99, "Server Error"),

    INVALID_SIZE_FOR_PRODUCT(400, -50, "product size is not valid"),
    CANNOT_TRADE_MYSELF(409, -51, "you can not buy or sell your item"),
    USER_DOES_NOT_MATCH_TRADE_UPDATE(401, -52, "user did not create this trade")
    ;
}