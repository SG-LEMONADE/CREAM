package com.cream.log.dto

data class PricesByDateDTO(
    val oneMonth: ArrayList<PriceDTO> = ArrayList(),
    val threeMonth: ArrayList<PriceDTO> = ArrayList(),
    val sixMonth: ArrayList<PriceDTO> = ArrayList(),
    val oneYear: ArrayList<PriceDTO> = ArrayList(),
    val total: ArrayList<PriceDTO> = ArrayList()
)