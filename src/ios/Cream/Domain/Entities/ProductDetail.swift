//
//  ProductDetail.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/08.
//

import Foundation

struct ProductDetail {
    let id: Int
    let imageUrls: [String]
    let brandName: String
    let originalName, translatedName: String
    let pricePremiumPercentage: Int?
    let changeValue, lastSalePrice, pricePremium: Int?
    let backgroundColor: String
    
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
    
    let relatedProducts: [Product]
}

extension ProductDetail {
    static func create() -> Self {
        return ProductDetail(id: 0, imageUrls: [], brandName: "", originalName: "", translatedName: "", pricePremiumPercentage: 0, changeValue: 0, lastSalePrice: 0, pricePremium: 0, backgroundColor: "", styleCode: "", releaseDate: "", color: "", originalPrice: 0, lowestAsk: 0, highestBid: 0, askPrices: [:], bidPrices: [:], wishList: [], wishCount: 0, sizes: [], lastCompletedTrade: [], asksBySizeCount: [], bidsBySizeCount: [], changePercentage: 0, relatedProducts: [])
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
