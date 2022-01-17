package com.cream.product.service

import com.cream.product.dto.PageDTO
import com.cream.product.dto.ProductDetailDTO
import com.cream.product.dto.ProductListDTO
import com.cream.product.persistence.MarketRepository
import com.cream.product.persistence.ProductRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Service

@Service
class ProductService {
    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var marketRepository: MarketRepository

    fun findProductsByPage(page: PageDTO): MutableList<ProductListDTO> {
        val foundProductsByPage = productRepository.findAll(PageRequest.of(page.cursor, page.perPage, Sort.by(page.sort))).content
        return foundProductsByPage.stream()
            .map { ProductListDTO(it) }
            .toList()
    }

    fun findProductByIdAndAllSize(id: Long): ProductDetailDTO{
        val product = productRepository.findById(id).orElseThrow()
        val market = marketRepository.findOneByProductIdAndSize(id, "ALL")
        return ProductDetailDTO(product, market)
    }

    fun findProductByIdAndSize(id: Long, size: String): ProductDetailDTO{
        val product = productRepository.findById(id).orElseThrow()
        val market = marketRepository.findOneByProductIdAndSize(id, size)
        return ProductDetailDTO(product, market)
    }
}