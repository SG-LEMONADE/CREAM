//
//  LoginViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import UIKit

struct LoginViewModel {
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    var isLoginAvailable: Observable<Bool> = Observable(false)
    
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
    
    mutating func validateLoginAvailable() {
        self.isLoginAvailable.value = validate(email: email.value) && validate(password: password.value)
    }
    
    func login(completion: @escaping () -> Void) {
        
    }
}
