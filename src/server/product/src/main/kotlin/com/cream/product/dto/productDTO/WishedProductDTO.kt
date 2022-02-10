package com.cream.product.dto.productDTO

import com.fasterxml.jackson.annotation.JsonRawValue
import com.querydsl.core.annotations.QueryProjection

data class WishedProductDTO @QueryProjection constructor(
    val id: Long,
    val brandName: String,
    val originalName: String,
    val size: String,
    @JsonRawValue val imageUrls: String,
    val backgroundColor: String,
    val lowestAsk: Int?
)