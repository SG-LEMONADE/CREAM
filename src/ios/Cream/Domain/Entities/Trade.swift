//
//  Trade.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

struct TradeList {
    var counter: Counter
    let trades: [Trade]
}

struct Counter {
    var totalCnt, waitingCnt, inProgressCnt, finishedCnt: Int
}

struct Trade {
    let id: Int
    let productId: Int
    let name: String
    let size: String
    let imageUrl: [String]
    let backgroundColor: String
    let tradeStatus: String
    let price: Int
    let updateDateTime: String?
    let validationDate: String
}

struct TradeRequest {
    let size: String
    let price: Int?
}

enum TradeStatus: String {
    case ask = "ALL"
    case finished = "FINISHED"
    case inProgress = "IN_PROGRESS"
    case waiting = "WAITING"
    
    var desctiprion: String {
        switch self {
        case .waiting:
            return "WAITING"
        case .finished:
            return "COMPLETED"
        default:
            return ""
        }
    }
}
