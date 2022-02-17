package com.cream.product.dto.productDTO

import com.cream.product.dto.productDTO.projectionDTO.WishedProductDTO

data class WishList(
    val count: Int,
    val products: List<WishedProductDTO>
)