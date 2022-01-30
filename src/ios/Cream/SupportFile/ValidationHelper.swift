//
//  ValidationHelper.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import Foundation

enum ValidationHelper {
    enum State: String {
        case valid = ""
        case emailFormatInvalid = "올바른 이메일을 입력해주세요."
        case passwordFormatInvalid = "영문, 숫자, 특수문자를 조합해서 입력해주세요 .(8-16자)"
        
        var description: String {
            rawValue
        }
    }
    
    static func validate(email: String) -> Bool {
        return Self.check(email, with: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$")
    }

    static func validate(password: String) -> Bool {
        return Self.check(password, with: "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[#?!@$%^&*-]).{8,16}$")
    }
}

private extension ValidationHelper {
    static func check(_ text: String, with regex: String) -> Bool {
        let range = NSRange(location: 0, length: text.count)
        if let idRegex = try? NSRegularExpression(pattern: regex) {
            return !idRegex.matches(in: text, options: [], range: range).isEmpty
        }
        return true
    }
}
