//
//  Product.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/24.
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
struct Product: Decodable {
    let productInfo: ProductInfo
    let wishList: [String]
    let lowestAsk: Int
}

// MARK: - ProductClass
struct ProductInfo: Decodable {
    let id: Int
    let backgroundColor: String
    let imageUrls: [String]
    let sizes: [String]
    let brandName: String
    let category: String
    let color: String
    let gender: String
    let originalName: String
    let originalPrice: Int
    let releasedDate: String
    let styleCode: String
    let totalSale: Int
    let translatedName: String
    let wishCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case backgroundColor, brandName, category, color,
             gender, id, imageUrls, originalName, originalPrice,
             releasedDate, sizes, styleCode, totalSale, translatedName
        case wishCount = "wishCnt"
    }
}

protocol ProductsServiceProtocol {
    func getProducts(completion: @escaping (_ success: Bool, _ results: Products?, _ error: String?) -> ())
}

class ProductsService: ProductsServiceProtocol {
    func getProducts(completion: @escaping (Bool, Products?, String?) -> ()) {
        
    }
}


