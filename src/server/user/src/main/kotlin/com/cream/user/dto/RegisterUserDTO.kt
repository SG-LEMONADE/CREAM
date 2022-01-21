package com.cream.user.dto

import com.cream.user.model.UserEntity
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime

data class RegisterUserDTO(
    val email: String,
    val password: String,
    val shoeSize: Int,
    val createdAt: LocalDateTime = LocalDateTime.now()
) {
    fun toEntity(encoder: PasswordEncoder): UserEntity {
        return UserEntity(
            email = this.email,
            password = encoder.encode(this.password),
            name = null,
            address = null,
            gender = null,
            age = null,
            shoeSize = this.shoeSize,
            profileImageUrl = "",
            status = 0,
            passwordChangedDateTime = this.createdAt,
            lastLoginDateTime = null,
            createAt = this.createdAt,
            updateAt = null
        )
    }
}