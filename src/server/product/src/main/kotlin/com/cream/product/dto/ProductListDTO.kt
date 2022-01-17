package com.cream.product.dto

import com.cream.product.model.ProductEntity
import java.time.LocalDate

data class ProductListDTO (
        val id: Long?,
        val name: String,
        val translatedName: String,
        val originalPrice: Int,
        val gender: Boolean,
        val category: String,
        val styleCode: String,
        val wishCnt: Int,
        val brandName: String,
        val backgroundColor: String,
        val imageUrls: String,
        val releaseDate: LocalDate?,
        val highestBid: Int,
        val totalSales: Int
) {
        constructor(productEntity: ProductEntity) : this(
                productEntity.id,
                productEntity.name,
                productEntity.translatedName,
                productEntity.originalPrice,
                productEntity.gender,
                productEntity.category,
                productEntity.styleCode,
                productEntity.wishCnt,
                productEntity.brandName,
                productEntity.backgroundColor,
                productEntity.imageUrls,
                productEntity.releaseDate,
                productEntity.highestBid,
                productEntity.totalSales
        )
}