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
    let id: Int
    let originalName, translatedName: String
    let originalPrice: Int
    let gender, category, color, styleCode: String
    let brandName, backgroundColor: String
    let imageUrls: [String]
    let sizes: [String]
    let releasedDate: String
    let totalSale: Int
    let wishList: [String]?
    let lowestAsk: Int?
    let highestBid: Int?
    let premiumPrice: Int?
    let wishCount: Int
}

extension Product {
    var totalSaleText: String {
        if totalSale < 10_000 {
            return "거래 \(totalSale.priceFormat)"
        } else {
            let value = Double(totalSale) / 10_000
            return "거래 \(round(value * 10)/10)만"
        }
    }
    
    var wishText: String {
        if wishCount < 10_000 {
            return wishCount.priceFormat
        } else {
            let value = Double(wishCount) / 10_000
            return "\(round(value * 10)/10)만"
        }
    }
    
    var price: String {
        if let lowestAsk = lowestAsk {
            return "\(lowestAsk.priceFormat)원"
        } else {
            return "-"
        }
    }
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
