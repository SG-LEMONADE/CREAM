//
//  ProductResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

// MARK: - ProductResponseDTO
struct ProductResponseDTO: Decodable {
    let product: ProductInfoResponseDTO
    let lastCompletedTrade: [CompletedTradeDTO]?
    let lowestAsk: Int?
    let highestBid: Int?
    let asksBySizeCount, bidsBySizeCount: [TradeBySizeCountDTO]
    let changePercentage: Double?
    let changeValue, lastSalePrice, pricePremium: Int?
    let backgroundColor: String?
    let pricePremiumPercentage: Int?
    let askPrices, bidPrices: [String: Int?]
    let relatedProducts: [ProductInfoResponseDTO]
}

extension ProductResponseDTO {
    func toDomain() -> ProductDetail {
        var trades: [CompletedTrade] = []
        lastCompletedTrade?.forEach {
            trades.append(.init(price: $0.price, size: $0.size, tradeDate: $0.tradeDate))
        }
        var asksSizes: [TradeBySizeCount] = []
        asksBySizeCount.forEach {
            asksSizes.append(.init(count: $0.count, price: $0.price, size: $0.size))
        }
        var bidsSizes: [TradeBySizeCount] = []
        bidsBySizeCount.forEach {
            bidsSizes.append(.init(count: $0.count, price: $0.price, size: $0.size))
        }
        
        var products: Products = []
        self.relatedProducts.forEach {
            products.append($0.toDomain())
        }
        return .init(id: product.id,
                     imageUrls: product.imageUrls,
                     brandName: product.brandName,
                     originalName: product.originalName,
                     translatedName: product.translatedName,
                     pricePremiumPercentage: pricePremiumPercentage,
                     changeValue: changeValue,
                     lastSalePrice: lastSalePrice,
                     pricePremium: pricePremium,
                     backgroundColor: product.backgroundColor,
                     styleCode: product.styleCode,
                     releaseDate: product.releasedDate ?? "-",
                     color: product.color ?? "-",
                     originalPrice: product.originalPrice,
                     lowestAsk: product.lowestAsk,
                     highestBid: product.highestBid,
                     askPrices: askPrices,
                     bidPrices: bidPrices,
                     wishList: product.wishList,
                     wishCount: product.wishCnt,
                     sizes: product.sizes,
                     lastCompletedTrade: trades,
                     asksBySizeCount: asksSizes,
                     bidsBySizeCount: bidsSizes,
                     changePercentage: changePercentage,
                     relatedProducts: products)
    }
}


// MARK: - TradeBySizeCountDTO
struct TradeBySizeCountDTO: Decodable {
    let count, price: Int
    let size: String
}

// MARK: - CompletedTradeDTO
struct CompletedTradeDTO: Decodable {
    let price: Int
    let size: String
    let tradeDate: String
}

// MARK: - ProductInfoResponseDTO
struct ProductInfoResponseDTO: Decodable {
    let id: Int
    let originalName, translatedName: String
    let originalPrice: Int
    let gender, category, styleCode: String
    let color: String?
    let wishCnt: Int
    let brandName, backgroundColor: String
    let imageUrls: [String]
    let sizes: [String]
    let releasedDate: String?
    let totalSale: Int
    let wishList: [String]?
    let lowestAsk: Int?
    let highestBid: Int?
    let premiumPrice: Int?
}

extension ProductInfoResponseDTO {
    func toDomain() -> Product {
        return .init(id: id,
                     originalName: originalName,
                     translatedName: translatedName,
                     originalPrice: originalPrice,
                     gender: gender,
                     category: category,
                     color: color ?? "-",
                     styleCode: styleCode,
                     brandName: brandName,
                     backgroundColor: backgroundColor,
                     imageUrls: imageUrls,
                     sizes: sizes,
                     releasedDate: releasedDate ?? "-",
                     totalSale: totalSale,
                     wishList: wishList,
                     lowestAsk: lowestAsk,
                     highestBid: highestBid,
                     premiumPrice: premiumPrice,
                     wishCount: wishCnt)
    }
}
