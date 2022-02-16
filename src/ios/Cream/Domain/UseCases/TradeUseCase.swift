//
//  TradeUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

// MARK: TradeUseCaseInterface
protocol TradeUseCaseInterface {
    func requestTrade(tradeType: TradeType,
                      productId: Int,
                      size: String,
                      price: Int,
                      validate: Int?,
                      completion: @escaping (Result<Void, Error>) -> Void)
}

// MARK: - TradeUseCase
final class TradeUseCase {
    private let repository: TradeRepositoryInterface
    
    init(_ repository: TradeRepositoryInterface) {
        self.repository = repository
    }
}

extension TradeUseCase: TradeUseCaseInterface {
    func requestTrade(tradeType: TradeType,
                      productId: Int,
                      size: String,
                      price: Int,
                      validate: Int?,
                      completion: @escaping (Result<Void, Error>) -> Void) {
        _ = repository.requestTrade(tradeType: tradeType,
                                productId: productId,
                                size: size,
                                price: price,
                                validate: validate) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
