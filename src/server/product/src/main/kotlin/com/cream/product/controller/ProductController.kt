package com.cream.product.controller

import com.cream.product.dto.PageDTO
import com.cream.product.dto.ProductDetailDTO
import com.cream.product.dto.ProductListDTO
import com.cream.product.service.ProductService
import com.cream.product.service.WishService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.support.Repositories
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
    fun findProductsByPage(page: PageDTO): ResponseEntity<List<ProductListDTO>> {
        return ResponseEntity.ok(productService.findProductsByPage(page))
    }

//    @GetMapping
//    fun findProductsByPage(page: PageDTO, @RequestHeader("userId") userId: Long): ResponseEntity<List<ProductListDTO>>{
//        return ResponseEntity.ok(productService.findProductsByPage(page))
//    }

    @GetMapping("/{id}")
    fun findProductById(@PathVariable id: Long): ResponseEntity<ProductDetailDTO> {
        return ResponseEntity.ok(productService.findProductByIdAndAllSize(id))
    }

    @GetMapping("/{id}/{size}")
    fun findProductByIdAndSize(@PathVariable id: Long, @PathVariable size: String): ResponseEntity<ProductDetailDTO>{
        return ResponseEntity.ok(productService.findProductByIdAndSize(id, size))
    }

    @PostMapping("/{id}/{size}/wish")
    fun createWish(@PathVariable id:Long, @PathVariable size: String, @RequestHeader("userId") userId: Long): ResponseEntity<Any>{
        wishService.toggleWish(userId, id, size)
        return ResponseEntity.ok().body(null)
    }
}