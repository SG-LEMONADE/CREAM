package com.cream.product.dto.filterDTO

import javax.validation.constraints.Max
import javax.validation.constraints.Min

data class PageDTO(

    @Min(0)
    val cursor: Long,

    @Max(200)
    val perPage: Long,

    val sort: String? = null
) {
    fun offset(): Long {
        return cursor * perPage
    }
}