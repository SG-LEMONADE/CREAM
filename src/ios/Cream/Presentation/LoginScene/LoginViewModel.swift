//
//  LoginViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit

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
    func confirmUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
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
    
    func confirmUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let _ = usecase.confirm(userEmail: email, userPassword: password) { result in
            switch result {
            case .success(let user):
                let accessToken = user.accessToken
                let refreshToken = user.refreshToken
                print("\(accessToken) \(refreshToken)")
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
