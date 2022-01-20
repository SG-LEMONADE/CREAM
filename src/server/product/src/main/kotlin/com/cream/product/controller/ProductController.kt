package com.cream.product.controller

import com.cream.product.dto.*
import com.cream.product.filter.ProductFilter
import com.cream.product.model.ProductEntity
import com.cream.product.model.WishEntity
import com.cream.product.service.ProductService
import com.cream.product.service.WishService
import com.querydsl.core.Tuple
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/products")
class ProductController {
    @Autowired
    lateinit var productService: ProductService

    @Autowired
    lateinit var wishService: WishService

    @GetMapping
    fun findProductsByPage(
        page: PageDTO,
        filter: ProductFilter,
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<List<ProductWishDTO?>> {
        return ResponseEntity.ok(productService.findProductsByPageWithWish(page, userId, filter))
    }

    @GetMapping("/{id}")
    fun findProductById(
        @PathVariable id: Long,
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<ProductDetailDTO?> {
        return ResponseEntity.ok(productService.findProductById(id, userId))
    }

    @PostMapping("/{productId}/wish/{size}")
    fun toggleWish(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<String>{
        wishService.toggleWish(userId, productId, size)
        return ResponseEntity.ok(null)
    }
}