//
//  ErrorList.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import Foundation

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
