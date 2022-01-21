package com.cream.user.error

enum class ErrorCode(
    val status: Int,
    var errCode: Int,
    var message: String
) {

    // Common
    INVALID_INPUT_VALUE(400, -1, "Invalid Input value"),
    METHOD_NOT_ALLOWED(405, -2, "Invalid Http method"),
    ENTITY_NOT_FOUND(400, -3, "Entity Not Found"),

    INTERNAL_SERVER_ERROR(500, -99, "Server Error"),

    // User
    USER_EMAIL_NOT_VERIFIED(400, -10, "user email is not admitted"),
    USER_NEED_TO_CHANGE_PASSWORD(400, -11, "user have to change password"),
    USER_NOT_FOUND(404, -12, "user is not found"),
    REFRESH_TOKEN_NOT_VALID(400, -13, "refresh token is not valid"),
    REFRESH_TOKEN_EXPIRED(400, -14, "refresh token is expired"),
    EMAIL_HASH_NOT_VALID(400, -15, "email hash value is not valid"),
    USER_TOKEN_NOT_VALID(400, -16, "token is not valid"),
    USER_ACCESS_DENIED(400, -17, "user is not acceptable"),
    DUPLICATED_USER_EMAIL(409, -18, "duplicated email"),
    USER_EMAIL_NOT_FOUND(404, -19, "user email not found"),
    USER_PASSWORD_NOT_MATCH(401, -20, "user password not match"),
    ;
}