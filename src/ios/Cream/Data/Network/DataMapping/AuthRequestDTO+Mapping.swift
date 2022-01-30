//
//  AuthRequestDTO.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct AuthRequestDTO: Encodable {
    let email: String
    let password: String
}
