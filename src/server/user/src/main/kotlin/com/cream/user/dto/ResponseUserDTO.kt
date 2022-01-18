package com.cream.user.dto

import com.cream.user.model.UserEntity
import java.time.LocalDateTime

data class ResponseUserDTO(
    val id: Long?,
    val email: String,
    val name: String?,
    val address: String?,
    val gender: Boolean?,
    val age: Int?,
    val shoeSize: Int,
    val profileImageUrl: String?,
    val status: Int,
    val passwordChangedDateTime: LocalDateTime,
    val lastLoginDateTime: LocalDateTime?,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime?,
) {
    constructor(userEntity: UserEntity) :
            this(
                userEntity.id,
                userEntity.email,
                userEntity.name,
                userEntity.address,
                userEntity.gender,
                userEntity.age,
                userEntity.shoeSize,
                userEntity.profileImageUrl,
                userEntity.status,
                userEntity.passwordChangedDateTime,
                userEntity.lastLoginDateTime,
                userEntity.createAt,
                userEntity.updateAt,
            )
}