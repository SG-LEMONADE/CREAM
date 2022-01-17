//
//  LoginViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import UIKit

class UserViewModel {
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var isLoginAvailable: Observable<Bool> = Observable(false)
    var error: Observable<String?> = Observable(nil)
    
    func validate(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return predicate.evaluate(with: email)
    }
    
    func validate(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[#?!@$%^&*-]).{8,16}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        return predicate.evaluate(with: password)
    }
    
    func validateLoginAvailable() {
        self.isLoginAvailable.value = validate(email: email.value) && validate(password: password.value)
    }
    

}

final class LoginViewModel: UserViewModel {
    
    func login(email: String, password: String) {
        NetworkService.shared.login(email: email, password: password) { [weak self] success in
            self?.error.value = success ? nil : "Invalid Credential!!!"
        }
    }
}
