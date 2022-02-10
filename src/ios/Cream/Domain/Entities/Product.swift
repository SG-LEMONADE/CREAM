//
//  Product.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

struct HomeInfo {
    let ads: [String]
    let sections: [Section]
}

struct SectionInfo {
    let header: String
    let detail: String
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
