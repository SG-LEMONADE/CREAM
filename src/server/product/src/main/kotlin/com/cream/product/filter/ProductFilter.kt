package com.cream.product.filter

data class ProductFilter(
    val category: String?,
    val brandId: String?,
    val collectionId: String?,
    val gender: Boolean?,
    val priceFrom: Int?,
    val priceTo: Int?,
    val keyWord: String?
        )