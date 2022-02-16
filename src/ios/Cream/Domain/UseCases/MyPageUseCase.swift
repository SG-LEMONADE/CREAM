//
//  MyPageUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import Foundation

// MARK: - MyPageUseCaseInterface
protocol MyPageUseCaseInterface {
    func fetchUserInfo(completion: @escaping (Result<User, UserError>) -> Void)
    func fetchTradeInfo(tradeType: TradeType, completion: @escaping (Result<TradeList, UserError>) -> Void)
}

// MARK: - MyPageUseCase
final class MyPageUseCase: MyPageUseCaseInterface {
    private let userRepository: UserRepositoryInterface
    private let tradeRepository: TradeRepositoryInterface
    
    init(userRepository: UserRepositoryInterface,
         tradeRepository: TradeRepositoryInterface) {
        self.userRepository = userRepository
        self.tradeRepository = tradeRepository
    }
    
    func fetchUserInfo(completion: @escaping (Result<User, UserError>) -> Void) {
        _ = userRepository.fetchUserInfo { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                
                switch errorMessage.code {
                case ErrorList.INVALID_INPUT_VALUE:
                    completion(.failure(.authInvalid))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
        
    }
    
    func fetchTradeInfo(tradeType: TradeType, completion: @escaping (Result<TradeList, UserError>) -> Void) {
        _ = tradeRepository.fetchTradeInfo(with: tradeType) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                
                switch errorMessage.code {
                case ErrorList.INVALID_INPUT_VALUE:
                    completion(.failure(.authInvalid))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
    }
}
