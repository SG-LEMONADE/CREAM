//
//  ErrorList.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import Foundation

// MARK: - Error List
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

// MARK: - User Error
enum UserError: Error {
    case authInvalid
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
        case .authInvalid:          return "로그아웃 후, 다시 로그인해주세요."
        }
    }
}

extension UserError: Equatable {
    static func == (lhs: UserError, rhs: UserError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}

enum FilterError: Error {
    case networkUnconnected
    case unknownError(Error)
    
    var userMessage: String {
        switch self {
        case .networkUnconnected:   return "정보를 받아오는데 실패했습니다.\n 개발자에게 문의해주세요."
        case .unknownError(_):      return "알수없는 에러 발생.\n 개발자에게 문의해주세요."
        }
    }
}

enum ProductError: Error {
    case networkUnconnected
    case unknownError(Error)
    case initValue
    
    var userMessage: String {
        switch self {
        case .networkUnconnected:   return "정보를 받아오는데 실패했습니다.\n 개발자에게 문의해주세요."
        case .unknownError(_):      return "알수없는 에러 발생.\n 개발자에게 문의해주세요."
        case .initValue:            return ""
        }
    }
}
