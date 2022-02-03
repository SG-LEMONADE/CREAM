package com.cream.user.constant

enum class UserStatus(
    val value: Int
) {
    NEED_CONFIRM_EMAIL(0),
    NEED_CHANGE_PASSWORD(1),
    EMAIL_CONFIRMED(2),
    DELETED_USER(3)
}