//
//  UserUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import Foundation

protocol UserUseCaseInterface {
    func confirm(userEmail: String,
                 userPassword: String,
                 completion: @escaping (Result<Auth, Error>) -> Void) -> Cancellable?
    
    func add(userEmail: String,
             userPassword: String,
             shoeSize: Int,
             completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

final class UserUseCase: UserUseCaseInterface {
    
    private let repository: UserRepositoryInterface
    
    init(_ userRepository: UserRepositoryInterface) {
        self.repository = userRepository
    }
    
    func confirm(userEmail: String, userPassword: String, completion: @escaping (Result<Auth, Error>) -> Void) -> Cancellable? {
        repository.confirm(email: userEmail, password: userPassword) { result in
            switch result {
            case .success(let auth):
                let auth = Auth(accessToken: auth.accessToken, refreshToken: auth.refreshToken)
                completion(.success(auth))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(userEmail: String, userPassword: String, shoeSize: Int, completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        repository.add(email: userEmail, password: userPassword, shoesize: shoeSize) { result in
            switch result {
            case .success(let userDTO):
                let user = User(email: userDTO.email,
                                name: userDTO.name,
                                address: userDTO.address,
                                gender: userDTO.gender,
                                age: userDTO.age,
                                shoeSize: userDTO.shoeSize,
                                profileImageUrl: userDTO.profileImageUrl,
                                lastLoginDateTime: userDTO.lastLoginDateTime)
                completion(.success(user))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
