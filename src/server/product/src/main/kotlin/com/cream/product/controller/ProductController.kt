package com.cream.product.controller

import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.productDTO.ProductDTO
import com.cream.product.dto.productDTO.ProductDetailDTO
import com.cream.product.dto.productDTO.WishList
import com.cream.product.service.ProductService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/products")
class ProductController {
    @Autowired
    lateinit var productService: ProductService

    @GetMapping
    fun findProductsByPage(
        page: PageDTO,
        filter: FilterRequestDTO,
        @RequestHeader("userId", required = false) userId: Long?
    ): ResponseEntity<List<ProductDTO>> {
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

    @GetMapping("/wishes")
    fun findProductsByWish(
        page: PageDTO,
        @RequestHeader("userId", required = true) userId: Long
    ): ResponseEntity<WishList> {
        return ResponseEntity.ok(productService.findProductByWish(page, userId))
    }
}