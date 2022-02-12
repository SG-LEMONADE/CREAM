//
//  FilterResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import Foundation


// MARK: - FilterResponseDTO
struct FilterResponseDTO {
    let brands: [BrandResponseDTO]
    let collections: [Any?]
    let gender, categories: [String]
}

// MARK: - BrandResponseDTO
struct BrandResponseDTO {
    let id: Int
    let name: String
    let logoImageURL: String?
}
