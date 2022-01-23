package com.cream.product.service

import com.cream.product.dto.*
import com.cream.product.dto.FilterRequestDTO
import com.cream.product.persistence.ProductRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import kotlin.streams.toList

@Service
class ProductService {
    @Autowired
    lateinit var productRepository: ProductRepository

    fun findProductsByPageWithWish(page: PageDTO, userId: Long?, filter: FilterRequestDTO): List<ProductWishDTO>? {
        return if (userId == null) {
            productRepository.getProducts(page.offset(), page.limit(), page.sort, filter)
        } else {
            productRepository.getProductsWithWish(userId, page.offset(), page.limit(), page.sort, filter)
        }
    }

    fun findProductById(id: Long, userId: Long?): ProductDetailDTO {
        return if (userId == null) {
            val product = productRepository.findById(id).orElseThrow()
            ProductDetailDTO(product)
        } else {
            val product = productRepository.getProductWithWish(userId, id)
            ProductDetailDTO(product!!)
        }
    }
}