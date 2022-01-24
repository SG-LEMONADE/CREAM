package com.cream.product.dto.productDTO

import com.cream.product.model.Trade

class ProductDetailDTO(
    val product: ProductPriceWishDTO,
    val pricesBySize: List<ProductPriceBySizeDTO>?,
    lastCompletedTrade: Trade?,
    lowestAsk: ProductPriceByRequestTypeDTO?,
    highestBid: ProductPriceByRequestTypeDTO?
) {
    var changePercentage: Float? = null
    var changeValue: Int? = null
    var lastSalePrice: Int? = null
    var pricePremium: Int? = null
    var pricePremiumPercentage: Float? = null
    var highestBid: Int? = null
    var lowestAsk: Int? = null

    init {
        if (lastCompletedTrade != null && lowestAsk != null) {
            this.changePercentage = (lastCompletedTrade.price - lowestAsk.price) / lowestAsk.price.toFloat()
            this.changeValue = (lastCompletedTrade.price - lowestAsk.price)
            this.lastSalePrice = lastCompletedTrade.price

            this.pricePremium = lowestAsk.price - product.product.originalPrice
            this.pricePremiumPercentage = (lowestAsk.price - product.product.originalPrice) / product.product.originalPrice.toFloat()
        }

        if (highestBid != null) {
            this.highestBid = highestBid.price
        }

        if (lowestAsk != null) {
            this.lowestAsk = lowestAsk.price
        }
    }
}