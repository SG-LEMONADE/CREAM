package com.cream.product.service

import com.cream.product.constant.RequestType
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

    fun findProductsByPageWithWish(page: PageDTO, userId: Long?, filter: FilterRequestDTO): List<ProductPriceWishDTO>? {
        if (userId == null) {
            return productRepository.getProducts(page.offset(), page.limit(), page.sort, filter)!!.stream()
                .map {
                    ProductPriceWishDTO(it.product, null, it.lowestAsk)
                }.toList()
        }
        return productRepository.getProductsWithWish(userId, page.offset(), page.limit(), page.sort, filter)
    }

    fun findProductById(id: Long, userId: Long?, size: String?): ProductDetailDTO {

        val product: ProductPriceWishDTO = if (userId == null) {
            val returnValue = productRepository.getProduct(id)
            ProductPriceWishDTO(returnValue.product, null, returnValue.lowestAsk)
        } else {
            productRepository.getProductWithWish(userId, id)
        }

        val lastCompletedTrade = productRepository.getLastTrade(id, size)
        val pricesBySize = productRepository.getProductPriceBySize(id)
        val lowestAsk = productRepository.getProductSizePriceByRequestType(id, size, RequestType.ASK)
        val highestBid = productRepository.getProductSizePriceByRequestType(id, size, RequestType.BID)

        return ProductDetailDTO(
            product,
            pricesBySize,
            lastCompletedTrade,
            lowestAsk,
            highestBid
        )
    }
}