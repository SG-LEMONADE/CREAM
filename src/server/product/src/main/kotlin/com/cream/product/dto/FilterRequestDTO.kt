package com.cream.product.dto

data class FilterRequestDTO(
    val category: String?,
    val brandId: String?,
    val collectionId: String?,
    val gender: String?,
    val priceFrom: Int?,
    val priceTo: Int?,
    val keyWord: String?
)