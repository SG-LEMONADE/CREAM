//
//  Filter.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

struct Filter {
    var categories: [String]
    var brands: [Brand]
    var collections: [String]
    var gender: [String]
}

struct Brand {
    let id: Int
    let name: String
    let logoImageUrl: String?
}

extension Brand {
    func toTranslatedName() -> String {
        return name
    }
}

struct SelectFilter {
    var category: String?
    var brands: [String]
    var collections: [String]
    var gender: String?
    
    init(category: String? = nil, brands: [String] = [], collections: [String] = [], gender: String? = nil) {
        self.category = category
        self.brands = brands
        self.collections = collections
        self.gender = gender
    }
}

extension SelectFilter {
    func brandsToString() -> String {
        var result: String = .init()
        brands.forEach {
            result += "\($0), "
        }
        result.removeLast(2)
        return result
    }
}
