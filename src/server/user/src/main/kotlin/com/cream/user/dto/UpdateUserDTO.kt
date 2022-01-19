package com.cream.user.dto

data class UpdateUserDTO (
        val email: String,
        val password: String,
        val name: String,
        val address: String,
        val shoeSize: Int,
        val profileImageUrl: String,
        val gender: Boolean,
        val age: Int
        )