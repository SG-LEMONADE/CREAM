package com.cream.product.dto.filterDTO

import com.fasterxml.jackson.databind.annotation.JsonDeserialize

@JsonDeserialize
data class FilterRequestDTO(
    val gender: String? = null,
    val brandId: String? = null,
    val keyword: String? = null,
    val priceTo: Int? = null,
    val category: String? = null,
    val priceFrom: Int? = null,
    val collectionId: String? = null,
    val recommendation: List<Long>? = null
)