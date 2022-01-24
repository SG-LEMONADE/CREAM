package com.cream.product.controller

import com.cream.product.dto.FilterResponseDTO
import com.cream.product.dto.PageDTO
import com.cream.product.dto.ProductDetailDTO
import com.cream.product.dto.ProductPriceWishDTO
import com.cream.product.dto.FilterRequestDTO
import com.cream.product.service.FilterService
import com.cream.product.service.ProductService
import com.cream.product.service.WishService
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

    @Autowired
    lateinit var filterService: FilterService

    @GetMapping
    fun findProductsByPage(
        page: PageDTO,
        filter: FilterRequestDTO,
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<List<ProductPriceWishDTO>> {
        return ResponseEntity.ok(productService.findProductsByPageWithWish(page, userId, filter))
    }

    @GetMapping("/{id}")
    fun findProductById(
        @PathVariable id: Long,
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<ProductDetailDTO> {
        return ResponseEntity.ok(productService.findProductById(id, userId, null))
    }

    @GetMapping("/{id}/{size}")
    fun findProductByIdAndSize(
        @PathVariable id: Long,
        @PathVariable size: String,
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<ProductDetailDTO> {
        return ResponseEntity.ok(productService.findProductById(id, userId, size))
    }

    @PostMapping("/{productId}/wish/{size}")
    fun toggleWish(
        @PathVariable productId: Long,
        @PathVariable size: String,
        @RequestHeader("userId") userId: Long
    ): ResponseEntity<Unit> {
        wishService.toggleWish(userId, productId, size)
        return ResponseEntity.ok(null)
    }

    @GetMapping("/filters")
    fun findFilters(): ResponseEntity<FilterResponseDTO> {
        return ResponseEntity.ok(filterService.findFilters())
    }
}