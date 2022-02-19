package com.cream.product.dto.productDTO

import com.cream.product.dto.tradeDTO.projectionDTO.TradeBySizeCountDTO
import com.cream.product.dto.tradeDTO.projectionDTO.TradeLastCompletedDTO

data class ProductDetailDTO(
    val product: ProductDTO,
    val lastCompletedTrades: List<TradeLastCompletedDTO>,
    val asksBySizeCount: List<TradeBySizeCountDTO>,
    val bidsBySizeCount: List<TradeBySizeCountDTO>,
    val lastSalePrice: Int?,
    val changePercentage: Float?,
    val changeValue: Int?,
    val pricePremiumPercentage: Float?,
    val askPrices: HashMap<String, Int?>,
    val bidPrices: HashMap<String, Int?>,
    val relatedProducts: List<ProductDTO>
)