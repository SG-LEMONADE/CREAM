package com.cream.product.dto

import java.time.LocalDate

interface ProductWithWishDTO {
    val id: Long?
    val originalName: String
    val translatedName: String
    val originalPrice: Int
    val gender: Boolean
    val category: String
    val color: String
    val styleCode: String
    val wishCnt: Int
    val collectionId: Long?
    val brandId: Long?
    val brandName: String
    val backgroundColor: String
    val imageUrls: String
    val sizes: String
    val releasedDate: LocalDate?
    val highestBid: Int
    val totalSale: Int
    var wishList: String?
}