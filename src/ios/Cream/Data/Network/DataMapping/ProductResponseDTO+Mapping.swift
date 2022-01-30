//
//  ProductResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

struct ProductResponseDTO: Decodable {
    let product: ProductInfoDTO
    let lastCompletedTrade: [CompletedTradeDTO]
    let lowestAsk: Int?
    let highestBid: Int?
    let asksBySizeCount, bidsBySizeCount: [TradeBySizeCountDTO]
    let changePercentage: Double?
    let changeValue, lastSalePrice, pricePremium: Int?
    let pricePremiumPercentage: Int?
    let askPrices, bidPrices: [String: Int?]
}

struct TradeBySizeCountDTO: Decodable {
    let count, price: Int
    let size: String
}


struct CompletedTradeDTO: Decodable {
    let price: Int
    let size: String
    let tradeDate: String
}

// MARK: - ProductInfoDTO
struct ProductInfoDTO: Decodable {
    let id: Int
    let originalName, translatedName: String
    let originalPrice: Int
    let gender, category, color, styleCode: String
    let wishCnt: Int
    let brandName, backgroundColor: String
    let imageUrls: [String]
    let sizes: [String]
    let releasedDate: String
    let totalSale: Int
    let wishList: [String]?
    let lowestAsk: Int?
    let highestBid: Int?
    let premiumPrice: Int?
}

extension ProductResponseDTO {
    func toDomain() -> ProductDetail {
        var trades: [CompletedTrade] = []
        lastCompletedTrade.forEach {
            trades.append(.init(price: $0.price,
                                size: $0.size,
                                tradeDate: $0.tradeDate))
        }
        var asksSizes: [TradeBySizeCount] = []
        asksBySizeCount.forEach {
            asksSizes.append(.init(count: $0.count,
                                   price: $0.price,
                                   size: $0.size))
        }
        var bidsSizes: [TradeBySizeCount] = []
        bidsBySizeCount.forEach {
            bidsSizes.append(.init(count: $0.count,
                                   price: $0.price,
                                   size: $0.size))
        }
        return ProductDetail(imageUrls: product.imageUrls,
                             brandName: product.brandName,
                             originalName: product.originalName,
                             translatedName: product.translatedName,
                             pricePremiumPercentage: pricePremiumPercentage,
                             changeValue: changeValue,
                             lastSalePrice: lastSalePrice,
                             pricePremium: pricePremium,
                             styleCode: product.styleCode,
                             releaseDate: product.releasedDate,
                             color: product.color,
                             originalPrice: product.originalPrice,
                             lowestAsk: lowestAsk,
                             highestBid: highestBid,
                             askPrices: askPrices,
                             bidPrices: bidPrices,
                             wishList: product.wishList,
                             wishCount: product.wishCnt,
                             sizes: product.sizes,
                             lastCompletedTrade: trades,
                             asksBySizeCount: asksSizes,
                             bidsBySizeCount: bidsSizes,
                             changePercentage: changePercentage)
    }
}


