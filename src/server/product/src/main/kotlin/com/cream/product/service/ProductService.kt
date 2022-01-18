package com.cream.product.service

import com.cream.product.dto.PageDTO
import com.cream.product.dto.ProductDetailDTO
import com.cream.product.dto.ProductListDTO
import com.cream.product.dto.ProductWithWishDTO
import com.cream.product.persistence.MarketRepository
import com.cream.product.persistence.ProductRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Service
import kotlin.streams.toList

@Service
class ProductService {
    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var marketRepository: MarketRepository

    fun findProductsByPageWithWish(page: PageDTO, userId: Long?): List<ProductListDTO> {
        return if (userId == null){
            val foundProductsByPage = productRepository.findAll(PageRequest.of(page.cursor, page.perPage, Sort.by(page.sort))).content
            foundProductsByPage.stream()
                .map { ProductListDTO(it) }
                .toList()
        } else {
            val foundProductsByPage = productRepository.findAllWithWish(userId, page.offset(), page.limit(), page.sort)
            foundProductsByPage.stream()
                .map{ ProductListDTO(it) }
                .toList()
        }
    }

    fun findProductById(id: Long, userId: Long?): ProductDetailDTO{
        val markets = marketRepository.findAllByProductId(id)
        return if (userId == null){
            val product = productRepository.findById(id).orElseThrow()
            ProductDetailDTO(product, markets)
        } else {
            val product = productRepository.findOneWithWish(userId, id)
            ProductDetailDTO(product, markets)
        }
    }
}