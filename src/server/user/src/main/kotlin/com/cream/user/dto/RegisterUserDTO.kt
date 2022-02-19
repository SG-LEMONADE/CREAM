package com.cream.user.dto

import com.cream.user.constant.UserStatus
import com.cream.user.model.User
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime
import javax.validation.constraints.Email
import javax.validation.constraints.Max
import javax.validation.constraints.Min
import javax.validation.constraints.Pattern

data class RegisterUserDTO(
    @field:Email
    val email: String,

    @field:Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}")
    val password: String,

    @field:Min(220)
    @field:Max(300)
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