package com.cream.product.dto

import com.cream.product.model.Brand
import com.cream.product.model.Collection

data class FilterResponseDTO(
    val brands: List<Brand>,
    val collections: List<Collection>,
    val gender: List<String>,
    val categories: List<String>
)