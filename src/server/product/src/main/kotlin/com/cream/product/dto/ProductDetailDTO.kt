package com.cream.product.dto

import com.cream.product.model.Product

data class ProductDetailDTO(
    val product: Product,
    val wishList: String?,
) {
    constructor(product: Product) : this(
        product,
        null
    )

    constructor(product: ProductWishDTO) : this(
        product.product,
        product.wishList
    )
}