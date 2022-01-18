package com.cream.product.dto

import com.cream.product.model.MarketEntity
import com.cream.product.model.ProductEntity
import java.time.LocalDate

data class ProductDetailDTO (
    val product: ProductEntity,
    val marketList: List<MarketEntity>,
    val wishList: String?,
) {
    constructor(product: ProductEntity, markets: List<MarketEntity>): this(
        product,
        markets,
        null
    )
    constructor(product: ProductWithWishDTO, markets: List<MarketEntity>): this(
        ProductEntity(product),
        markets,
        product.wishList
    )
}