package com.cream.product.dto.productDTO.projectionDTO

import com.cream.product.model.Product
import com.querydsl.core.annotations.QueryProjection

data class ProductPriceWishDTO @QueryProjection constructor(
    val product: Product,
    val wishList: String?,
    val lowestAsk: Int?,
    val highestBid: Int?,
    val premiumPrice: Int?,
)