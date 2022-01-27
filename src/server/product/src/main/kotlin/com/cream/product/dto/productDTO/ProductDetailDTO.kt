package com.cream.product.dto.productDTO

import com.cream.product.dto.tradeDTO.TradeBySizeCountDTO
import com.cream.product.model.Trade
import org.json.JSONArray

class ProductDetailDTO(
    val product: ProductDTO,
    askPricesBySize: List<ProductPriceBySizeDTO>?,
    bidPricesBySize: List<ProductPriceBySizeDTO>?,
    val lastCompletedTrade: List<Trade>,
    lowestAsk: ProductPriceByRequestTypeDTO?,
    highestBid: ProductPriceByRequestTypeDTO?,
    val asksBySizeCount: List<TradeBySizeCountDTO>,
    val bidsBySizeCount: List<TradeBySizeCountDTO>
) {
    var changePercentage: Float? = null
    var changeValue: Int? = null
    var lastSalePrice: Int? = null
    var pricePremium: Int? = null
    var pricePremiumPercentage: Float? = null
    var highestBid: Int? = null
    var lowestAsk: Int? = null
    var askPrices: HashMap<String, Int?> = java.util.HashMap()
    var bidPrices: HashMap<String, Int?> = java.util.HashMap()

    init {

        if (lastCompletedTrade.isNotEmpty()) {
            val latestTrade = lastCompletedTrade[0]
            if (lowestAsk?.price != null) {
                this.changePercentage = (lowestAsk.price - latestTrade.price) / latestTrade.price.toFloat()
                this.changeValue = (lowestAsk.price - latestTrade.price)

                this.pricePremium = lowestAsk.price - product.originalPrice
                this.pricePremiumPercentage = (lowestAsk.price - product.originalPrice) / product.originalPrice.toFloat()
            }

            this.lastSalePrice = latestTrade.price
        }

        if (highestBid?.price != null) {
            this.highestBid = highestBid.price
        }

        if (lowestAsk?.price != null) {
            this.lowestAsk = lowestAsk.price
        }

        askPricesBySize?.forEach {
            askPrices[it.size] = it.lowestAsk
        }

        bidPricesBySize?.forEach {
            bidPrices[it.size] = it.lowestAsk
        }

        JSONArray(product.sizes)
            .forEach {
                if (!askPrices.containsKey(it)) askPrices[it as String] = null
                if (!bidPrices.containsKey(it)) bidPrices[it as String] = null
            }
    }
}