package com.cream.user.converter

import com.cream.user.constant.UserStatus
import com.cream.user.error.ErrorCode
import com.cream.user.error.UserCustomException
import javax.persistence.AttributeConverter
import javax.persistence.Converter

@Converter
class UserStatusConverter : AttributeConverter<UserStatus, Int> {
    override fun convertToDatabaseColumn(attribute: UserStatus?): Int {
        return attribute?.value ?: 0
    }

    override fun convertToEntityAttribute(dbData: Int?): UserStatus {
        return when (dbData) {
            0 -> UserStatus.NEED_CONFIRM_EMAIL
            1 -> UserStatus.NEED_CHANGE_PASSWORD
            2 -> UserStatus.EMAIL_CONFIRMED
            3 -> UserStatus.DELETED_USER
            else -> throw UserCustomException(ErrorCode.INVALID_INPUT_VALUE)
        }
    }
}