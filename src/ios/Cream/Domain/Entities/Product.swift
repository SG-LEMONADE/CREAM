//
//  Product.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

struct HomeData {
    let ads: [String]
    let sections: [SectionInfo]
}

struct SectionInfo {
    let header: String
    let detail: String
    let imageUrl: String
    let products: [Product]
}

typealias Products = [Product]
// MARK: - Product
struct Product {
    let productInfo: ProductInfo
    let wishList: [String]
    let lowestAsk: Int
}

struct ProductDetail {
    let imageUrls: [String]
    let brandName: String
    let originalName, translatedName: String
    let pricePremiumPercentage: Int?
    let changeValue, lastSalePrice, pricePremium: Int?
    
    let styleCode, releaseDate, color: String
    let originalPrice: Int
    
    
    let lowestAsk: Int?
    let highestBid: Int?
    
    let askPrices, bidPrices: [String: Int?]
    let wishList: [String]?
    let wishCount: Int
    
    let sizes: [String]
    
    let lastCompletedTrade: [CompletedTrade]
    
    let asksBySizeCount, bidsBySizeCount: [TradeBySizeCount]
    
    let changePercentage: Double?
}

extension ProductDetail {
    static func create() -> Self {
        return ProductDetail(imageUrls: [], brandName: "", originalName: "", translatedName: "", pricePremiumPercentage: 0, changeValue: 0, lastSalePrice: 0, pricePremium: 0, styleCode: "", releaseDate: "", color: "", originalPrice: 0, lowestAsk: 0, highestBid: 0, askPrices: [:], bidPrices: [:], wishList: [], wishCount: 0, sizes: [], lastCompletedTrade: [], asksBySizeCount: [], bidsBySizeCount: [], changePercentage: 0)
    }
}

struct TradeBySizeCount {
    let count, price: Int
    let size: String
}

struct CompletedTrade {
    let price: Int
    let size: String
    let tradeDate: String
}

// MARK: - ProductClass
struct ProductInfo {
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
    let wishList: [String?]
    let lowestAsk: Int?
    let highestBid: Int?
    let premiumPrice: Int?
    let wishCount: Int
}
