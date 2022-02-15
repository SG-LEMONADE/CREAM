package com.cream.product.dto.filterDTO

data class PageDTO(
    val cursor: Long,

    val perPage: Long,

    val sort: String? = null
) {
    fun offset(): Long {
        return cursor * perPage
    }
}