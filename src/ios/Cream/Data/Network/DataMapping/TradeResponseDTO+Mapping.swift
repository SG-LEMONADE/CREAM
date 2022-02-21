//
//  TradeResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/14.
//

import Foundation

// MARK: - ProductResponseDTO
struct TradeResponseDTO: Decodable {
    let counter: CounterDTO
    let trades: [TradeDTO]
}

extension TradeResponseDTO {
    func toDomain() -> TradeList {
        var tradeList: [Trade] = []
        trades.forEach {
            tradeList.append($0.toDomain())
        }
        return .init(counter: counter.toDomain(), trades: tradeList)
    }
}

// MARK: - CounterDTO
struct CounterDTO: Decodable {
    let totalCnt, waitingCnt, inProgressCnt, finishedCnt: Int
}

extension CounterDTO {
    func toDomain() -> Counter {
        return .init(totalCnt: totalCnt,
                     waitingCnt: waitingCnt,
                     inProgressCnt: inProgressCnt,
                     finishedCnt: finishedCnt)
    }
}

// MARK: - TradeDTO
struct TradeDTO: Decodable {
    let id: Int
    let productId: Int
    let name: String
    let size: String
    let price: Int
    let imageUrl: [String]
    let backgroundColor: String
    let tradeStatus: String
    let updateDateTime: String?
    let validationDate: String
}

extension TradeDTO {
    func toDomain() -> Trade {
        if let update = validationDate.split(separator: "T").map({ String($0) }).first {
            return .init(id: id,
                         productId: productId,
                         name: name,
                         size: size,
                         imageUrl: imageUrl,
                         backgroundColor: backgroundColor,
                         tradeStatus: tradeStatus,
                         price: price,
                         updateDateTime: updateDateTime,
                         validationDate: update)
        } else {
            return .init(id: id,
                         productId: productId,
                         name: name,
                         size: size,
                         imageUrl: imageUrl,
                         backgroundColor: backgroundColor,
                         tradeStatus: tradeStatus,
                         price: price,
                         updateDateTime: updateDateTime,
                         validationDate: validationDate)
        }
    }
}
