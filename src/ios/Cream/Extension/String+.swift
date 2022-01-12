//
//  String+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegExValidation = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegExValidation)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegExValidation = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,16}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegExValidation)
        return predicate.evaluate(with: self)
    }
}
