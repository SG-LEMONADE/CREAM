package com.cream.product.dto.homeDTO

import com.cream.product.dto.productDTO.ProductDTO

data class HomeDTO(
    val adImageUrls: List<HomeAdDTO>,
    val sections: List<SectionDTO>,
    val recommendedItems: List<ProductDTO>?
)