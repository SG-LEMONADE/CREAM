//
//  JoinViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import Foundation

protocol JoinViewModelProperty {
    var emailMessage: Observable<String> { get set }
    var passwordMessage: Observable<String> { get set }
    var shoeSize: Observable<Int> { get set }
    var isJoinAvailable: Observable<Bool> { get set }
}

protocol JoinViewModelValidatable {
    func validateEmail(_ email: String)
    func validatePassword(_ password: String)
}

protocol JoinViewModelOutput {
    func didValidateEmail()
    func didValidatePassword()
}

protocol JoinViewModel: JoinViewModelProperty, JoinViewModelValidatable {
    func addUser(email: String, password: String, shoesize: Int, completion: @escaping (Result<User, Error>) -> ())
}

final class DefaultJoinViewModel: JoinViewModel {
    var usecase: UserUseCaseInterface
    var emailMessage: Observable<String> = Observable(" ")
    var passwordMessage: Observable<String> = Observable(" ")
    var isJoinAvailable: Observable<Bool> = Observable(false)
    var shoeSize: Observable<Int> = Observable(0)
    
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
        isJoinAvailable.value = (passwordMessage.value == "" && emailMessage.value == "")
    }
    
    func addUser(email: String, password: String, shoesize: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let _ = usecase.add(userEmail: email, userPassword: password, shoeSize: shoesize) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}