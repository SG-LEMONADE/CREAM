//
//  JoinResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct JoinResponseDTO: Decodable {
    let email: String
    let name: String?
    let address: String?
    let gender: Int?
    let age: String?
    let shoeSize: Int
    let profileImageUrl: String
    let status: String
    let passwordChangedDateTime: String
    let lastLoginDateTime: String?
    let createdAt: String
    let updatedAt: String?
}

extension JoinResponseDTO {
    func toDomain() -> User {
        return .init(email: email,
                     name: name,
                     address: address,
                     gender: gender,
                     age: age,
                     shoeSize: shoeSize,
                     profileImageUrl: profileImageUrl,
                     lastLoginDateTime: lastLoginDateTime)
    }
}
