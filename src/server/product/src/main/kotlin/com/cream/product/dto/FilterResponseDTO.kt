package com.cream.product.dto

import com.cream.product.model.BrandEntity
import com.cream.product.model.CollectionEntity

data class FilterResponseDTO(
    val brands: List<BrandEntity>,
    val collections: List<CollectionEntity>,
    val gender: List<String>,
    val categories: List<String>
)