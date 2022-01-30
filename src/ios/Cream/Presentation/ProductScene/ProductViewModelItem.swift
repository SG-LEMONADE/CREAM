//
//  ProductViewModelItem.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import Foundation

// TODO: 프로토콜과 Enum 활용
enum ProductViewModelItemType {
    case image
    case info
    case releasion
//    case delivery
//    case advertise
    case qoute
    case similarity
}

protocol ProductViewModelItem {
    var type: ProductViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension ProductViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class ProductViewModelImageItem: ProductViewModelItem {
    var type: ProductViewModelItemType {
        return .image
    }
    
    var sectionTitle: String {
        return "Main Info"
    }
    
    var imageUrls: [String]
    
    init(_ imageUrls: [String]) {
        self.imageUrls = imageUrls
    }
}

struct Info {
    var brand: String
    var detailInfo: String
    var translatedName: String
    var lastPrice: String
    var size: [String]
}

class ProductViewModelInfoItem: ProductViewModelItem {
    var type: ProductViewModelItemType {
        return .info
    }
    
    var sectionTitle: String {
        return "Main Info"
    }
}
