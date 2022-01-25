package com.cream.product.service

import com.cream.product.constant.RequestType
import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.productDTO.ProductDTO
import com.cream.product.dto.productDTO.ProductDetailDTO
import com.cream.product.dto.productDTO.ProductPriceWishDTO
import com.cream.product.persistence.ProductRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import kotlin.streams.toList
@Service
class ProductService {
    @Autowired
    lateinit var productRepository: ProductRepository

    fun findProductsByPageWithWish(page: PageDTO, userId: Long?, filter: FilterRequestDTO): List<ProductDTO> {
        if (userId == null) {
            return productRepository.getProducts(page.offset(), page.limit(), page.sort, filter).stream()
                .map {
                    ProductDTO(ProductPriceWishDTO(it.product, null, it.lowestAsk))
                }.toList()
        }
        return productRepository.getProductsWithWish(userId, page.offset(), page.limit(), page.sort, filter).stream()
            .map {
                ProductDTO(it)
            }.toList()
    }

    fun findProductById(id: Long, userId: Long?, size: String?): ProductDetailDTO {

        val product: ProductPriceWishDTO = if (userId == null) {
            val returnValue = productRepository.getProduct(id)
            ProductPriceWishDTO(returnValue.product, null, returnValue.lowestAsk)
        } else {
            productRepository.getProductWithWish(userId, id)
        }

        val lastCompletedTrade = productRepository.getLastTrade(id, size)
        val askPricesBySize = productRepository.getProductPricesBySize(id, RequestType.ASK)
        val bidPricesBySize = productRepository.getProductPricesBySize(id, RequestType.BID)
        val lowestAsk = productRepository.getProductSizePriceByRequestType(id, size, RequestType.ASK)
        val highestBid = productRepository.getProductSizePriceByRequestType(id, size, RequestType.BID)

        return ProductDetailDTO(
            ProductDTO(product),
            askPricesBySize,
            bidPricesBySize,
            lastCompletedTrade,
            lowestAsk,
            highestBid
        )
    }

    fun findProductByWish(page: PageDTO, userId: Long): List<ProductDTO>{
        return productRepository.getProductsByWish(userId, page.offset(), page.limit()).stream()
            .map {
                ProductDTO(it)
            }.toList()
    }
}