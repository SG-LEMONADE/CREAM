package com.cream.user.dto

import com.cream.user.model.UserEntity
import java.time.LocalDateTime

data class ResponseUserDTO(
    val email: String,
    val name: String,
    val address: String,
    val gender: Boolean,
    val age: Int,
    val shoeSize: Int,
    val marriageInfo: String,
    val profileImageUrl: String,
    val status: Int,
    val passwordChangedDateTime: LocalDateTime,
    val lastLoginDateTime: LocalDateTime?,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime?,
    val refreshToken: String
) {
    constructor(userEntity: UserEntity, token: String) :
            this(
                userEntity.email,
                userEntity.name,
                userEntity.address,
                userEntity.gender,
                userEntity.age,
                userEntity.shoeSize,
                userEntity.marriageInfo,
                userEntity.profileImageUrl,
                userEntity.status,
                userEntity.passwordChangedDateTime,
                userEntity.lastLoginDateTime,
                userEntity.createAt,
                userEntity.updateAt,
                token
            )
}