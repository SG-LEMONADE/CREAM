//
//  FilterResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import Foundation


// MARK: - FilterResponseDTO
struct FilterResponseDTO: Decodable {
    let categories: [String]
    let brands: [BrandResponseDTO]
    let collections: [String]
    let gender: [String]
}

extension FilterResponseDTO {
    func toDomain() -> Filter {
        var brandInfo: [Brand] = []
        brands.forEach {
            brandInfo.append($0.toDomain())
        }
        return .init(categories: categories,
                     brands: brandInfo,
                     collections: collections,
                     gender: gender)
    }
}

// MARK: - BrandResponseDTO
struct BrandResponseDTO: Decodable {
    let id: Int
    let name: String
    let logoImageUrl: String?
}

extension BrandResponseDTO {
    func toDomain() -> Brand {
        return .init(id: id,
                     name: name,
                     logoImageUrl: logoImageUrl)
    }
}
