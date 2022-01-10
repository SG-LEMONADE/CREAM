package com.cream.user.dto

import com.cream.user.model.UserEntity
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime

data class RegisterUserDTO(
    val email: String,
    val password: String,
    val name: String,
    val address: String,
    val gender: Boolean,
    val age: Int,
    val shoeSize: Int,
    val marriageInfo: String?,
    val createdAt: LocalDateTime = LocalDateTime.now()
) {
    fun toEntity(encoder: PasswordEncoder): UserEntity{
        return UserEntity(
            email = this.email,
            password = encoder.encode(this.password),
            name = this.name,
            address = this.address,
            gender = this.gender,
            age = this.age,
            shoeSize = this.shoeSize,
            marriageInfo = this.marriageInfo,
            profileImageUrl = "",
            status = 0,
            passwordChangedDateTime = this.createdAt,
            lastLoginDateTime = null,
            createAt = this.createdAt,
            updateAt = null
        )
    }
}