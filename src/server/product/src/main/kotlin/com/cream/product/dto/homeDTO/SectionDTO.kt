package com.cream.product.dto.homeDTO

import com.cream.product.dto.productDTO.ProductDTO
import com.cream.product.model.Section

data class SectionDTO(
    val header: String,
    val detail: String,
    val imageUrl: String,
    val backgroundColor: String?,
    val products: List<ProductDTO>
) {
    constructor(section: Section, products: List<ProductDTO>):
        this(section.header, section.detail, section.imageUrl, section.backgroundColor, products)
}