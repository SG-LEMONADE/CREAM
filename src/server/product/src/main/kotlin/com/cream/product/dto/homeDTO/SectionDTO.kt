package com.cream.product.dto.homeDTO

import com.cream.product.dto.productDTO.ProductDTO

data class SectionDTO(
    val header: String,
    val detail: String,
    val imageUrl: String,
    val products: List<ProductDTO>
)