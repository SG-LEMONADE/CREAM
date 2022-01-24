package com.cream.product.controller

import com.cream.product.constant.RequestType
import com.cream.product.dto.tradeDTO.TradeRegisterDTO
import com.cream.product.service.TradeService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/trades")
class TradeController {
    @Autowired
    lateinit var tradeService: TradeService

    @PostMapping("/products/{productId}/{size}")
    fun createTrade(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestHeader("userId") userId: Long,
        @RequestBody tradeDTO: TradeRegisterDTO
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(tradeService.create(tradeDTO, userId, productId, size))
    }

    @PostMapping("/sell/select/{productId}/{size}")
    fun sellProduct(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(tradeService.buyOrSellProduct(productId, size, RequestType.BID, userId))
    }

    @PostMapping("/buy/select/{productId}/{size}")
    fun buyProduct(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(tradeService.buyOrSellProduct(productId, size, RequestType.ASK, userId))
    }

    @DeleteMapping("/{tradeId}")
    fun deleteTrade(
        @PathVariable tradeId: Long
    ): ResponseEntity<Unit> {
        return ResponseEntity.ok(tradeService.delete(tradeId))
    }
}