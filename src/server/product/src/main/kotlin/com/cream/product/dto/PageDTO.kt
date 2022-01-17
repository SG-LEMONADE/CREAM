package com.cream.product.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class PageDTO (
    val cursor: Int,
    @JsonProperty("per_page") val perPage: Int,
    val sort: String
    )