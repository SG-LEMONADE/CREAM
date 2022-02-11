package com.cream.user.dto

data class UpdateUserDTO(
    val password: String?,
    val name: String?,
    val address: String?,
    val shoeSize: Int?,
    val profileImageUrl: String?
)