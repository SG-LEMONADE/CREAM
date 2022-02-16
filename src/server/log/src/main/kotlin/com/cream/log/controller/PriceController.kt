package com.cream.log.controller

import com.cream.log.dto.PricesByDateDTO
import com.cream.log.model.Price
import com.cream.log.service.PriceService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/prices")
class PriceController {

    @Autowired
    lateinit var priceService: PriceService

    @GetMapping("/products/{productId}")
    fun getPricesByDate(
        @PathVariable productId: Long
    ): ResponseEntity<PricesByDateDTO> {
        return ResponseEntity.ok(priceService.getPriceListByDate(productId, null))
    }

    @GetMapping("/products/{productId}/{size}")
    fun getPricesByDateAndSize(
        @PathVariable productId: Long,
        @PathVariable size: String
    ): ResponseEntity<PricesByDateDTO>{
        return ResponseEntity.ok(priceService.getPriceListByDate(productId, size))
    }

    @PostMapping("/products/{productId}/{size}")
    fun createPrice(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestBody price: Long
    ): ResponseEntity<Price> {
        return ResponseEntity.ok(priceService.create(productId, size, price))
    }
}