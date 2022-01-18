package com.cream.product.dto

import com.cream.product.model.BrandEntity
import com.cream.product.model.CollectionEntity
import com.cream.product.model.ProductEntity
import java.time.LocalDate

class ProductListDTO (
        val id: Long?,
        val originalName: String,
        val translatedName: String,
        val originalPrice: Int,
        val gender: Boolean,
        val category: String,
        val color: String,
        val styleCode: String,
        val wishCnt: Int,
        val brandId: Long?,
        val collectionId: Long?,
        val brandName: String,
        val backgroundColor: String,
        val imageUrls: String,
        val sizes: String,
        val releasedDate: LocalDate?,
        val highestBid: Int,
        val totalSale: Int,
) {
        constructor(productEntity: ProductEntity) : this(
                productEntity.id,
                productEntity.originalName,
                productEntity.translatedName,
                productEntity.originalPrice,
                productEntity.gender,
                productEntity.category,
                productEntity.color,
                productEntity.styleCode,
                productEntity.wishCnt,
                null,
                null,
                productEntity.brandName,
                productEntity.backgroundColor,
                productEntity.imageUrls,
                productEntity.sizes,
                productEntity.releasedDate,
                productEntity.highestBid,
                productEntity.totalSale,
        )
        constructor(productEntity: ProductWithWishDTO) : this(
                productEntity.id,
                productEntity.originalName,
                productEntity.translatedName,
                productEntity.originalPrice,
                productEntity.gender,
                productEntity.category,
                productEntity.color,
                productEntity.styleCode,
                productEntity.wishCnt,
                null,
                null,
                productEntity.brandName,
                productEntity.backgroundColor,
                productEntity.imageUrls,
                productEntity.sizes,
                productEntity.releasedDate,
                productEntity.highestBid,
                productEntity.totalSale,
        )
}