//
//  LoginViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit
import SwiftKeychainWrapper

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}

protocol LoginViewModelProperty {
    var emailMessage: Observable<String> { get set }
    var passwordMessage: Observable<String> { get set }
    var isLoginAvailable: Observable<Bool> { get set }
}

protocol LoginViewModelValidatable {
    func validateEmail(_ email: String)
    func validatePassword(_ password: String)
}

protocol LoginViewModel: LoginViewModelProperty, LoginViewModelValidatable {
    func confirmUser(email: String, password: String, completion: @escaping (Result<Bool, UserError>) -> Void)
}

final class DefaultLoginViewModel: LoginViewModel {
    var usecase: UserUseCaseInterface
    var emailMessage: Observable<String> = Observable(" ")
    var passwordMessage: Observable<String> = Observable(" ")
    var isLoginAvailable: Observable<Bool> = Observable(false)
    
    init(usecase: UserUseCaseInterface) {
        self.usecase = usecase
    }
    
    func validateEmail(_ email: String) {
        if ValidationHelper.validate(email: email) {
            self.emailMessage.value = ValidationHelper.State.valid.description
        } else {
            self.emailMessage.value = ValidationHelper.State.emailFormatInvalid.description
        }
        validateFormatAvailable()
    }
    
    func validatePassword(_ password: String) {
        if ValidationHelper.validate(password: password) {
            self.passwordMessage.value = ValidationHelper.State.valid.description
        } else {
            self.passwordMessage.value = ValidationHelper.State.passwordFormatInvalid.description
        }
        validateFormatAvailable()
    }
    
    private func validateFormatAvailable() {
        isLoginAvailable.value = passwordMessage.value == "" &&
        emailMessage.value == ""
    }
    
    func confirmUser(email: String, password: String, completion: @escaping (Result<Bool, UserError>) -> Void) {
        
        let _ = usecase.confirm(userEmail: email, userPassword: password) { result in
            switch result {
            case .success(let user):
                KeychainWrapper.standard.set(user.accessToken, forKey: "accessToken")
                KeychainWrapper.standard.set(user.refreshToken, forKey: "refreshToken")
                completion(.success(true))
            case .failure(let error):
                guard let error = error as? DataTransferError,
                      let errorMessage = error.errorMessage
                else { return }
                
                switch errorMessage.code {
                case
                    ErrorList.USER_EMAIL_NOT_FOUND,
                    ErrorList.USER_PASSWORD_NOT_MATCH:
                    completion(.failure(.userNotAccepted))
                case ErrorList.INTERNAL_SERVER_ERROR:
                    completion(.failure(.networkUnconnected))
                default:
                    completion(.failure(.unknownError))
                }
            }
        }
    }
}

enum UserError: Error {
    case userNotAccepted
    case duplicatedEmail
    case refreshTokenIsNotValid
    case unknownError
    case networkUnconnected
}

enum ErrorList {
    static let INVALID_INPUT_VALUE          = -1
    static let METHOD_NOT_ALLOWED           = -2
    static let ENTITY_NOT_FOUND             = -3
    static let INTERNAL_SERVER_ERROR        = -99
    static let USER_EMAIL_NOT_VERIFIED      = -10
    static let USER_NEED_TO_CHANGE_PASSWORD = -11
    static let USER_NOT_FOUND               = -12
    static let REFRESH_TOKEN_NOT_VALID      = -13
    static let REFRESH_TOKEN_EXPIRED        = -14
    static let EMAIL_HASH_NOT_VALID         = -15
    static let USER_TOKEN_NOT_VALID         = -16
    static let USER_ACCESS_DENIED           = -17
    static let DUPLICATED_USER_EMAIL        = -18
    static let USER_EMAIL_NOT_FOUND         = -19
    static let USER_PASSWORD_NOT_MATCH      = -20
    static let USER_TOKEN_EXPIRED           = -21
    static let USER_TOKEN_EMPTY             = -22
}
