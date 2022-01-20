package com.cream.product.service

import com.cream.product.dto.*
import com.cream.product.filter.ProductFilter
import com.cream.product.model.ProductEntity
import com.cream.product.model.WishEntity
import com.cream.product.persistence.MarketRepository
import com.cream.product.persistence.ProductRepository
import com.querydsl.core.Tuple
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

    fun findProductsByPageWithWish(page: PageDTO, userId: Long?, filter: ProductFilter): List<ProductWishDTO>? {
        return if (userId == null){
            productRepository.getProducts(page.offset(), page.limit(), page.sort, filter)
                ?.stream()?.map {
                    ProductWishDTO(it, null)
                }?.toList()
        } else {
            productRepository.getProductsWithWish(userId, page.offset(), page.limit(), page.sort, filter)
        }
    }

    fun findProductById(id: Long, userId: Long?): ProductDetailDTO{
        val markets = marketRepository.findAllByProductId(id)
        return if (userId == null) {
            val product = productRepository.findById(id).orElseThrow()
            ProductDetailDTO(product, markets)
        } else {
            val product = productRepository.getProductWithWish(userId, id)
            ProductDetailDTO(product!!, markets)
        }
    }
}