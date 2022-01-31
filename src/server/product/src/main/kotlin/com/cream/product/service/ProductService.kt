package com.cream.product.service

import com.cream.product.constant.RequestType
import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.productDTO.ProductDTO
import com.cream.product.dto.productDTO.ProductDetailDTO
import com.cream.product.dto.productDTO.ProductPriceWishDTO
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.TradeRepository
import org.json.JSONArray
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import kotlin.streams.toList

@Service
class ProductService {

    @Autowired
    lateinit var tradeRepository: TradeRepository

    @Autowired
    lateinit var productRepository: ProductRepository

    fun findProductsByPageWithWish(page: PageDTO, userId: Long?, filter: FilterRequestDTO): List<ProductDTO> {
        if (userId == null) {
            return productRepository.getProducts(page.offset(), page.limit(), page.sort, filter).stream()
                .map {
                    ProductDTO(it)
                }.toList()
        }
        return productRepository.getProductsWithWish(userId, page.offset(), page.limit(), page.sort, filter).stream()
            .map {
                ProductDTO(it)
            }.toList()
    }

    fun findProductById(id: Long, userId: Long?, size: String?): ProductDetailDTO {

        val product: ProductPriceWishDTO = if (userId == null) {
            productRepository.getProduct(id, size)
        } else {
            productRepository.getProductWithWish(userId, id, size)
        }

        val askPricesBySize = productRepository.getProductPricesBySize(id, RequestType.ASK)
        val bidPricesBySize = productRepository.getProductPricesBySize(id, RequestType.BID)

        val lastCompletedTrade = tradeRepository.findByProductIdCompleted(id)
        val asksBySizeCount = tradeRepository.findByProductIdWithCount(size, id, RequestType.ASK)
        val bidsBySizeCount = tradeRepository.findByProductIdWithCount(size, id, RequestType.BID)

        var changePercentage: Float? = null
        var changeValue: Int? = null
        var lastSalePrice: Int? = null
        var pricePremiumPercentage: Float? = null
        val askPrices: HashMap<String, Int?> = java.util.HashMap()
        val bidPrices: HashMap<String, Int?> = java.util.HashMap()

        if (lastCompletedTrade.isNotEmpty()) {
            val latestCompletedTrade = lastCompletedTrade[0]
            lastSalePrice = latestCompletedTrade.price

            if (product.lowestAsk != null) {
                changePercentage = ((product.lowestAsk - latestCompletedTrade.price) / latestCompletedTrade.price).toFloat()
                changeValue = (product.lowestAsk - latestCompletedTrade.price)
            }
        }

        if (product.premiumPrice != null) {
            pricePremiumPercentage = (product.premiumPrice / product.product.originalPrice).toFloat()
        }

        askPricesBySize?.forEach {
            askPrices[it.size] = it.lowestAsk
        }

        bidPricesBySize?.forEach {
            bidPrices[it.size] = it.lowestAsk
        }

        JSONArray(product.product.sizes)
            .forEach {
                if (!askPrices.containsKey(it)) askPrices[it as String] = null
                if (!bidPrices.containsKey(it)) bidPrices[it as String] = null
            }

        return ProductDetailDTO(
            ProductDTO(product),
            lastCompletedTrade,
            asksBySizeCount,
            bidsBySizeCount,
            lastSalePrice,
            changePercentage,
            changeValue,
            pricePremiumPercentage,
            askPrices,
            bidPrices
        )
    }

    fun findProductByWish(page: PageDTO, userId: Long): List<ProductDTO> {
        return productRepository.getProductsByWish(userId, page.offset(), page.limit()).stream()
            .map {
                ProductDTO(it)
            }.toList()
    }
}