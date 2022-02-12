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
}

enum UserError: Error {
    case userNotAccepted
    case duplicatedEmail
    case networkUnconnected
    case needEmailVerified
    case unknownError(Error)
    
    var userMessage: String {
        switch self {
        case .userNotAccepted:      return "이메일 또는 비밀번호를 확인해주세요."
        case .duplicatedEmail:      return "이미 사용중인 이메일입니다."
        case .networkUnconnected:   return "서버 문제로 로그인에 실패했습니다.\n 개발자에게 문의해주세요."
        case .needEmailVerified:    return "이메일 인증이 필요합니다.\n인증을 진행해주세요."
        case .unknownError(_):      return "알수없는 에러 발생.\n 개발자에게 문의해주세요."
        }
    }
}

extension UserError: Equatable {
    static func == (lhs: UserError, rhs: UserError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
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
}
