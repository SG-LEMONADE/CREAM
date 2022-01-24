package com.cream.product.dto.productDTO

import com.cream.product.model.Product

data class ProductPriceDTO(
    val product: Product,
    val lowestAsk: Int?
)