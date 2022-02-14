//
//  MockUserUseCase.swift
//  CreamTests
//
//  Created by wankikim-MN on 2022/02/14.
//

import Foundation
@testable import Cream

final class MockUserService: UserUseCaseInterface {
    
    private let isSuccess: Bool
    
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }
    
    func confirm(userEmail: String, userPassword: String, completion: @escaping (Result<Auth, UserError>) -> Void) {
        if isSuccess {
            completion(.success(.init(accessToken: "accessToken", refreshToken: "failureToken")))
        } else {
            completion(.failure(.authInvalid))
        }
    }
    
    func add(userEmail: String, userPassword: String, shoeSize: Int, completion: @escaping (Result<User, UserError>) -> Void) {
        if isSuccess {
            completion(.success(.init(email: userEmail, name: nil, address: nil, gender: nil, age: nil, shoeSize: shoeSize, profileImageUrl: "", lastLoginDateTime: nil)))
        } else {
            completion(.failure(.userNotAccepted))
        }
    }
    
    func removeToken(completion: @escaping (Result<Void, UserError>) -> Void) {
        
    }
    
    func verifyToken(completion: @escaping (Result<Void, UserError>) -> Void) {
        
    }
    
    func reissuanceToken(completion: @escaping (Result<Auth, UserError>) -> Void) {
        
    }
    
    func fetchUserInfo(completion: @escaping (Result<User, UserError>) -> Void) {
         
    }
}


