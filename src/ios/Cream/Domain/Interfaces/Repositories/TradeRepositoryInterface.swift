//
//  TradeRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

protocol TradeRepositoryInterface {
    func fetchTradeInfo(with type: TradeType, completion: @escaping (Result<TradeList, Error>) -> Void) -> Cancellable
    func requestTrade(tradeType: TradeType,
                      productId: Int,
                      size: String,
                      price: Int,
                      validate: Int?,
                      completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable
}
