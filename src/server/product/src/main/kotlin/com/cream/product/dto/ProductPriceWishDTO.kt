package com.cream.product.dto

import com.cream.product.model.Product

data class ProductPriceWishDTO(
    val product: Product,
    val wishList: String?,
    val lowestAsk: Int?
)