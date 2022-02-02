package com.cream.product.service

import com.cream.product.client.LogServiceClient
import com.cream.product.constant.RequestType
import com.cream.product.dto.UserLogDTO
import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.productDTO.ProductDTO
import com.cream.product.dto.productDTO.ProductDetailDTO
import com.cream.product.dto.productDTO.ProductPriceWishDTO
import com.cream.product.error.BaseException
import com.cream.product.error.ErrorCode
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.TradeRepository
import com.fasterxml.jackson.databind.ObjectMapper
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

    @Autowired
    lateinit var logServiceClient: LogServiceClient

    fun findProductsByPageWithWish(
        page: PageDTO,
        userId: Long?,
        filter: FilterRequestDTO
    ): List<ProductDTO> {
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

    fun findProductById(
        id: Long,
        userId: Long?,
        size: String?
    ): ProductDetailDTO {

        val product: ProductPriceWishDTO
        if (userId == null) {
            product = productRepository.getProduct(id, size)
        } else {
            product = productRepository.getProductWithWish(userId, id, size)
            logServiceClient.insertUserLogData(UserLogDTO(userId, id, 1))
        }

        if (size != null && !ObjectMapper().readValue(product.product.sizes, ArrayList::class.java).contains(size)) {
            throw BaseException(ErrorCode.INVALID_SIZE_FOR_PRODUCT)
        }

        val askPricesBySize = productRepository.getProductPricesBySize(id, RequestType.ASK)
        val bidPricesBySize = productRepository.getProductPricesBySize(id, RequestType.BID)

        val lastCompletedTrades = tradeRepository.findByProductIdCompleted(id)
        val asksBySizeCount = tradeRepository.findByProductIdWithCount(size, id, RequestType.ASK)
        val bidsBySizeCount = tradeRepository.findByProductIdWithCount(size, id, RequestType.BID)

        var changePercentage: Float? = null
        var changeValue: Int? = null
        var lastSalePrice: Int? = null
        var pricePremiumPercentage: Float? = null
        val askPrices: HashMap<String, Int?> = java.util.HashMap()
        val bidPrices: HashMap<String, Int?> = java.util.HashMap()

        if (lastCompletedTrades.isNotEmpty()) {
            val latestCompletedTrade = lastCompletedTrades[0]
            lastSalePrice = latestCompletedTrade.price

            if (lastCompletedTrades.size > 1) {
                changePercentage = ((lastCompletedTrades[1].price - latestCompletedTrade.price) / lastCompletedTrades[1].price).toFloat()
                changeValue = (lastCompletedTrades[1].price - latestCompletedTrade.price)
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
            lastCompletedTrades,
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

    fun findProductByWish(
        page: PageDTO,
        userId: Long
    ): List<ProductDTO> {
        return productRepository.getProductsByWish(userId, page.offset(), page.limit()).stream()
            .map {
                ProductDTO(it)
            }.toList()
    }
}