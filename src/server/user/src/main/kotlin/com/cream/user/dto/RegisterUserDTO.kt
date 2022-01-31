package com.cream.user.dto

import com.cream.user.constant.UserStatus
import com.cream.user.model.User
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime

data class RegisterUserDTO(
    val email: String,
    val password: String,
    val shoeSize: Int,
    val createdAt: LocalDateTime = LocalDateTime.now()
) {
    fun toEntity(encoder: PasswordEncoder): User {
        return User(
            email = this.email,
            password = encoder.encode(this.password),
            name = null,
            address = null,
            gender = null,
            age = null,
            shoeSize = this.shoeSize,
            profileImageUrl = "",
            status = UserStatus.NEED_CONFIRM_EMAIL,
            passwordChangedDatetime = this.createdAt,
            lastLoginDatetime = null,
            createdAt = this.createdAt,
            updatedAt = null
        )
    }
}