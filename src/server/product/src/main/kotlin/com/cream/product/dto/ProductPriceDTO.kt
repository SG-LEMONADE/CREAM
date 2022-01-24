package com.cream.product.dto

import com.cream.product.model.Product

data class ProductPriceDTO(
    val product: Product,
    val lowestAsk: Int?
)