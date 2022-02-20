//
//  MockMyPageUseCase.swift
//  CreamTests
//
//  Created by wankikim-MN on 2022/02/21.
//

import Foundation
@testable import Cream

final class MockMyPageUsecase: MyPageUseCaseInterface {
    private let isSuccess: Bool
    
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }
    
    func fetchUserInfo(completion: @escaping (Result<User, UserError>) -> Void) {
        if isSuccess {
            completion(.success(.init(email: "he_cat@naver.com",
                                      name: nil,
                                      address: nil,
                                      gender: nil,
                                      age: nil,
                                      shoeSize: 280,
                                      profileImageUrl: "",
                                      lastLoginDateTime: nil)))
        } else {
            completion(.failure(.authInvalid))
        }
    }
    
    func fetchTradeInfo(tradeType: TradeType,
                        completion: @escaping (Result<TradeList, UserError>) -> Void) {
        if isSuccess {
            completion(.success(.init(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: [.init(name: "name", size: "size", imageUrl: [], backgroundColor: "backgroundColor", tradeStatus: "tradeStatus", updateDateTime: nil, validationDate: "")])))
        } else {
            completion(.failure(.authInvalid))
        }
    }
}
