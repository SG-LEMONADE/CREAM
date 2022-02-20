//
//  Trade.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

struct TradeList {
    let counter: Counter
    let trades: [Trade]
}

struct Counter {
    let totalCnt, waitingCnt, inProgressCnt, finishedCnt: Int
}

struct Trade {
    let name: String
    let size: String
    let imageUrl: [String]
    let backgroundColor: String
    let tradeStatus: String
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
