package com.cream.user.dto

import javax.validation.constraints.Max
import javax.validation.constraints.Min
import javax.validation.constraints.Pattern

data class UpdateUserDTO(

    @field:Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}")
    val password: String?,
    val name: String?,
    val address: String?,

    @field:Min(220)
    @field:Max(300)
    val shoeSize: Int?,

    val profileImageUrl: String?
)