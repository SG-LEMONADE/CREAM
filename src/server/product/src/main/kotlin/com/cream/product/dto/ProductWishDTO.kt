package com.cream.product.dto

import com.cream.product.model.Product

data class ProductWishDTO(
    val product: Product,
    val wishList: String?
)