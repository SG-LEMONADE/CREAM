package com.cream.product.controller

import com.cream.product.service.WishService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/wish")
class WishController {

    @Autowired
    lateinit var wishService: WishService

    @PostMapping("/{productId}/{size}")
    fun toggleWish(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<Unit> {
        wishService.toggleWish(userId, productId, size)
        return ResponseEntity.ok(null)
    }
}