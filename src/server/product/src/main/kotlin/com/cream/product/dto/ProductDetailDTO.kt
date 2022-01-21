package com.cream.product.dto

import com.cream.product.model.MarketEntity
import com.cream.product.model.ProductEntity

data class ProductDetailDTO(
    val product: ProductEntity,
    val marketList: List<MarketEntity>,
    val wishList: String?,
) {
    constructor(product: ProductEntity, markets: List<MarketEntity>) : this(
        product,
        markets,
        null
    )

    constructor(product: ProductWishDTO, markets: List<MarketEntity>) : this(
        product.product,
        markets,
        product.wishList
    )
}