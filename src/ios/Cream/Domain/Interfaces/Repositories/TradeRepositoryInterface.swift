//
//  TradeRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

protocol TradeRepositoryInterface {
    func fetchTradeInfo(with type: TradeType, completion: @escaping (Result<TradeList, Error>) -> Void) -> Cancellable
}
