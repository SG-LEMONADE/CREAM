//
//  HomeResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/07.
//

import Foundation

// MARK: - AdImageResponseDTO
struct AdImageResponseDTO: Decodable {
    let imageUrl: String
    let backgroundColor: String
}

// MARK: - HomeResponseDTO
struct HomeResponseDTO: Decodable {
    let adImageUrls: [AdImageResponseDTO]
    let sections: [SectionResponseDTO]
    let recommendedItems: [ProductInfoResponseDTO]
}

extension HomeResponseDTO {
    func toDomain() -> HomeInfo {
        var imageUrls: [String] = []
        adImageUrls.forEach {
            imageUrls.append($0.imageUrl)
        }
        
        let recommendSection: Section = .init(header: "당신만을 위한 추천 상품", detail: "Only for YOU🎁", imageUrl: "", products: recommendedItems.map { $0.toDomain() })
        
        var sectionInfo: [Section] = [recommendSection]
        sections.forEach {
            sectionInfo.append($0.toDomain())
        }
        return HomeInfo(ads: imageUrls, sections: sectionInfo)
    }
}

// MARK: - SectionResponseDTO
struct SectionResponseDTO: Decodable {
    let header: String
    let detail: String
    let imageUrl: String
    let products: [ProductInfoResponseDTO]
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


