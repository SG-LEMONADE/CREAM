//
//  HomeResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/07.
//

import Foundation

struct HomeResponseDTO: Decodable {
    let adImageUrls: [String]
    let sections: [SectionResponseDTO]
}

extension HomeResponseDTO {
    func toDomain() -> HomeInfo {
        var sectionInfo: [Section] = []
        sections.forEach {
            sectionInfo.append($0.toDomain())
        }
        return HomeInfo(ads: adImageUrls, sections: sectionInfo)
    }
}

struct SectionResponseDTO: Decodable {
    let header: String
    let detail: String
    let imageUrl: String
    let products: [ProductInfoResponseDTO]
}

struct Section {
    let header: String
    let detail: String
    let imageUrl: String
    let products: [Product]
}

extension SectionResponseDTO {
    func toDomain() -> Section {
        var products: Products = []
        self.products.forEach {
            products.append($0.toDomain())
        }
        
        return Section(header: header, detail: detail, imageUrl: imageUrl, products: products)
    }
}


