//
//  PriceResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/19.
//

import Foundation

// MARK: - ProductResponseDTO
struct PriceResponseDTO: Decodable {
    let oneMonth    : [PriceListDTO]
    let threeMonth  : [PriceListDTO]
    let sixMonth    : [PriceListDTO]
    let oneYear     : [PriceListDTO]
    let total       : [PriceListDTO]
}

extension PriceResponseDTO {
    func toDomain() -> [[PriceList]] {
        var priceList: [[PriceList]] = []
        
        priceList.append(oneMonth.map { $0.toDomain() })
        priceList.append(threeMonth.map { $0.toDomain() })
        priceList.append(sixMonth.map { $0.toDomain() })
        priceList.append(oneYear.map { $0.toDomain() })
        priceList.append(total.map { $0.toDomain() })
        
        return priceList
    }
}

// MARK: - PriceList
struct PriceListDTO: Decodable {
    let date: String
    let price: Int
}

extension PriceListDTO {
    func toDomain() -> PriceList {
        return .init(date: date,
                     price: price)
    }
}

