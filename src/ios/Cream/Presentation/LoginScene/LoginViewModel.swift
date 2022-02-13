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

protocol LoginViewModelInput {
    func validateEmail(_ email: String)
    func validatePassword(_ password: String)
    func confirmUser(email: String, password: String, completion: @escaping (Result<Bool, UserError>) -> Void)
}

protocol LoginViewModelOutput {
    var emailMessage: Observable<String> { get set }
    var passwordMessage: Observable<String> { get set }
    var isLoginAvailable: Observable<Bool> { get set }
}

protocol LoginViewModelInterface: LoginViewModelInput, LoginViewModelOutput { }

final class LoginViewModel: LoginViewModelInterface {
    private let usecase: UserUseCaseInterface
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
                KeychainWrapper.standard.set(user.accessToken, forKey: KeychainWrapper.Key.accessToken)
                KeychainWrapper.standard.set(user.refreshToken, forKey: KeychainWrapper.Key.refreshToken)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
