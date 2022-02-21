package com.cream.product.service

import com.cream.product.client.LogServiceClient
import com.cream.product.constant.RequestType
import com.cream.product.dto.UserLogDTO
import com.cream.product.dto.filterDTO.FilterRequestDTO
import com.cream.product.dto.filterDTO.PageDTO
import com.cream.product.dto.productDTO.*
import com.cream.product.dto.productDTO.projectionDTO.ProductPriceWishDTO
import com.cream.product.error.BaseException
import com.cream.product.error.ErrorCode
import com.cream.product.persistence.ProductRepository
import com.cream.product.persistence.TradeRepository
import com.cream.product.persistence.WishRepository
import feign.FeignException
import org.json.JSONArray
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.lang.Integer.min
import kotlin.Int.Companion.MAX_VALUE
import kotlin.streams.toList

@Service
class ProductService {

    @Autowired
    lateinit var tradeRepository: TradeRepository

    @Autowired
    lateinit var productRepository: ProductRepository

    @Autowired
    lateinit var wishRepository: WishRepository

    @Autowired
    lateinit var logServiceClient: LogServiceClient

    private val log = LoggerFactory.getLogger(javaClass)

    fun findProductsByPageWithWish(
        page: PageDTO,
        userId: Long?,
        filter: FilterRequestDTO
    ): List<ProductDTO> {
        if (userId == null) {
            return productRepository.getProducts(page.offset(), page.perPage, page.sort, filter).stream()
                .map {
                    ProductDTO(it)
                }.toList()
        }
        return productRepository.getProductsWithWish(userId, page.offset(), page.perPage, page.sort, filter).stream()
            .map {
                ProductDTO(it)
            }.toList()
    }

    fun findProductById(
        id: Long,
        userId: Long?,
        size: String?
    ): ProductDetailDTO {
        val productWithWish: ProductPriceWishDTO
        if (userId == null) {
            productWithWish = productRepository.getProduct(id, size)
        } else {
            productWithWish = productRepository.getProductWithWish(userId, id, size)
            try {
                logServiceClient.insertUserLogData(UserLogDTO(userId, id, 1))
            } catch (ex: FeignException) {
                log.error(ex.message)
            }
        }

        val brandId: Long? = productWithWish.product.brand?.id
        val collectionId: Long? = productWithWish.product.collection?.id
        val product = ProductDTO(productWithWish)

        if (size != null && !product.sizes.contains(size)) {
            throw BaseException(ErrorCode.INVALID_SIZE_FOR_PRODUCT)
        }

        val askPricesBySize = productRepository.getProductPricesBySize(id, RequestType.ASK)
        val bidPricesBySize = productRepository.getProductPricesBySize(id, RequestType.BID)

        val lastCompletedTrades = tradeRepository.findByProductIdCompleted(id, size)
        val asksBySizeCount = tradeRepository.findByProductIdWithCount(size, id, RequestType.ASK)
        val bidsBySizeCount = tradeRepository.findByProductIdWithCount(size, id, RequestType.BID)

        // 관련 상품들을 가져옵니다.
        val relatedProducts = productRepository
            .getProducts(
                0, 6, "total_sale",
                FilterRequestDTO(
                    brandId = brandId.toString(),
                    collectionId = collectionId?.toString(),
                    category = product.category,
                    gender = product.gender
                )
            )
            .filter {
                // 같은 물건을 추천 할 수 없음
                it.product.id != product.id
            }
            .stream().map {
                ProductDTO(it)
            }.toList()

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
                changePercentage = ((latestCompletedTrade.price - lastCompletedTrades[1].price) / lastCompletedTrades[1].price).toFloat()
                changeValue = (latestCompletedTrade.price - lastCompletedTrades[1].price)
            }
        }

        if (product.premiumPrice != null) {
            pricePremiumPercentage = (product.premiumPrice / product.originalPrice).toFloat()
        }

        // 모든 사이즈의 최소 구매 가격이 없다면 null 입니다.
        var lowestPrice = MAX_VALUE
        askPricesBySize?.forEach {
            askPrices[it.size] = it.lowestAsk
            lowestPrice = min(lowestPrice, it.lowestAsk)
        }
        // 모든 사이즈에 대한 가격의 정보가 없다면 null
        if (lowestPrice == MAX_VALUE) {
            askPrices["모든 사이즈"] = null
        } else {
            askPrices["모든 사이즈"] = lowestPrice
        }

        bidPricesBySize?.forEach {
            bidPrices[it.size] = it.lowestAsk
        }

        // 화면에 그려줄 사이즈를 위해 가격이 없는 사이즈들도 배열로 만들어줍니다.
        JSONArray(product.sizes)
            .forEach {
                if (!askPrices.containsKey(it)) askPrices[it as String] = null
                if (!bidPrices.containsKey(it)) bidPrices[it as String] = null
            }

        return ProductDetailDTO(
            product,
            lastCompletedTrades,
            asksBySizeCount,
            bidsBySizeCount,
            lastSalePrice,
            changePercentage,
            changeValue,
            pricePremiumPercentage,
            askPrices,
            bidPrices,
            relatedProducts
        )
    }

    fun findProductByWish(
        page: PageDTO,
        userId: Long
    ): WishList {
        val products = productRepository.getProductsByWish(userId, page.offset(), page.perPage)
        val totalCount = wishRepository.getWishCount(userId)
        return WishList(totalCount, products)
    }
}