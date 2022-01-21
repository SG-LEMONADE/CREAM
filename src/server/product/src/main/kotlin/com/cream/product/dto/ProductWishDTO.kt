package com.cream.product.dto

import com.cream.product.model.ProductEntity

data class ProductWishDTO(
    val product: ProductEntity,
    val wishList: String?
)