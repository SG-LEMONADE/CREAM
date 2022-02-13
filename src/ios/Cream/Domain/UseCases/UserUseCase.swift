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
                 completion: @escaping (Result<Auth, UserError>) -> Void) -> Cancellable?
    
    func add(userEmail: String,
             userPassword: String,
             shoeSize: Int,
             completion: @escaping (Result<User, UserError>) -> Void) -> Cancellable?
    
    func removeToken(completion: @escaping (Result<Void, UserError>) -> Void)
    func verifyToken(completion: @escaping (Result<Void, UserError>) -> Void)
    func reissuanceToken(completion: @escaping (Result<Auth, UserError>) -> Void)
    func fetchUserInfo(completion: @escaping (Result<User, UserError>) -> Void)
}

final class UserUseCase: UserUseCaseInterface {
    
    private let repository: UserRepositoryInterface
    
    init(_ userRepository: UserRepositoryInterface) {
        self.repository = userRepository
    }
    
    func confirm(userEmail: String, userPassword: String, completion: @escaping (Result<Auth, UserError>) -> Void) -> Cancellable? {
        repository.confirm(email: userEmail, password: userPassword) { result in
            switch result {
            case .success(let auth):
                let auth = Auth(accessToken: auth.accessToken, refreshToken: auth.refreshToken)
                completion(.success(auth))
            case .failure(let error):
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                
                switch errorMessage.code {
                case
                    ErrorList.USER_EMAIL_NOT_FOUND,
                    ErrorList.USER_PASSWORD_NOT_MATCH:
                    completion(.failure(.userNotAccepted))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                case ErrorList.USER_EMAIL_NOT_VERIFIED:
                    completion(.failure(.needEmailVerified))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
    }
    
    func add(userEmail: String, userPassword: String, shoeSize: Int, completion: @escaping (Result<User, UserError>) -> Void) -> Cancellable? {
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
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                switch errorMessage.code {
                case
                    ErrorList.DUPLICATED_USER_EMAIL:
                    completion(.failure(.duplicatedEmail))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
    }
    
    func verifyToken(completion: @escaping (Result<Void, UserError>) -> Void) {
        _ = repository.verifyToken { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                
                switch errorMessage.code {
                case
                    ErrorList.DUPLICATED_USER_EMAIL:
                    completion(.failure(.duplicatedEmail))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
    }
    
    func reissuanceToken(completion: @escaping (Result<Auth, UserError>) -> Void) {
        _ = repository.reissueToken { result in
            switch result {
            case .success(let auth):
                let auth = Auth(accessToken: auth.accessToken, refreshToken: auth.refreshToken)
                completion(.success(auth))
            case .failure(let error):
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                
                switch errorMessage.code {
                case
                    ErrorList.DUPLICATED_USER_EMAIL:
                    completion(.failure(.duplicatedEmail))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
    }
    
    func removeToken(completion: @escaping (Result<Void, UserError>) -> Void) {
        _ = repository.removeToken { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                guard let decodedError = error as? DataTransferError,
                      let errorMessage = decodedError.errorMessage
                else { return }
                
                switch errorMessage.code {
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
        }
    }
    
    func fetchUserInfo(completion: @escaping (Result<User, UserError>) -> Void) {
        _ = repository.fetchUserInfo { result in
            switch result {
            case .success(let result):
                completion(.success(result))
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
