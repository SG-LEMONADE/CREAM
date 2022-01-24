package com.cream.product.dto.filterDTO

import com.fasterxml.jackson.annotation.JsonProperty

data class PageDTO(
    val cursor: Long,

    @JsonProperty("per_page")
    val perPage: Long,

    val sort: String
) {
    fun offset(): Long {
        return cursor * perPage
    }

    fun limit(): Long {
        return (cursor * perPage) + perPage
    }
}