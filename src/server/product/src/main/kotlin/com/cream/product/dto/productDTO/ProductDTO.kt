package com.cream.product.dto.productDTO

import com.fasterxml.jackson.annotation.JsonRawValue
import java.time.LocalDate

open class ProductDTO(data: ProductPriceWishDTO) {
    val id: Long? = data.product.id
    val originalName: String = data.product.originalName
    val translatedName: String = data.product.translatedName
    val originalPrice: Int = data.product.originalPrice
    val gender: String = data.product.gender
    val category: String = data.product.category
    val color: String = data.product.color
    val styleCode: String = data.product.styleCode
    val wishCnt: Int = data.product.wishCnt
    val brandName: String = data.product.brandName
    val backgroundColor: String = data.product.backgroundColor
    @JsonRawValue val imageUrls: String = data.product.imageUrls
    @JsonRawValue val sizes: String = data.product.sizes
    val releasedDate: LocalDate? = data.product.releasedDate
    val totalSale: Int = data.product.totalSale
    val wishList: List<String>? = if (data.wishList.isNullOrBlank()) null else data.wishList.split(",")
    val lowestAsk: Int? = data.lowestAsk
}