package com.cream.product.controller

import com.cream.product.dto.PageDTO
import com.cream.product.dto.ProductDetailDTO
import com.cream.product.dto.ProductListDTO
import com.cream.product.dto.ProductWithWishDTO
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

    @GetMapping
    fun findProductsByPage(page: PageDTO, @RequestHeader("userId") userId: Long?): ResponseEntity<List<ProductListDTO>> {
        return ResponseEntity.ok(productService.findProductsByPageWithWish(page, userId))
    }

    @GetMapping("/{id}")
    fun findProductById(@PathVariable id: Long, @RequestHeader("userId") userId: Long?): ResponseEntity<ProductDetailDTO> {
        return ResponseEntity.ok(productService.findProductById(id, userId))
    }

    @PostMapping("/{productId}/wish/{size}")
    fun toggleWish(@PathVariable productId:Long, @PathVariable size: String ,@RequestHeader("userId") userId: Long): ResponseEntity<String>{
        return ResponseEntity.ok(wishService.toggleWish(userId, productId, size))
    }
}