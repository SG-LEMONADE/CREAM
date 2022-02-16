//
//  TradeRequestDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import Foundation

// MARK: - ProductResponseDTO
struct TradeRequestDTO: Decodable {
    let price: Int
    let requestType: String
    let validationDay: Int
}

