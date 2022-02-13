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
