//
//  AuthRequestDTO.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

// MARK: - AuthRequestDTO
struct AuthRequestDTO: Encodable {
    let email: String
    let password: String
}
