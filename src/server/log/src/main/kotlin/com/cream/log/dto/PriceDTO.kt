package com.cream.log.dto

import com.cream.log.model.Price
import java.time.LocalDate

data class PriceDTO(
    val date: LocalDate,
    val price: Long
) {
    constructor(price: Price) : this(
        price.createdDate,
        price.price
    )
}