//
//  UserResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

// MARK: - UserResponseDTO
struct UserResponseDTO: Decodable {
    let id: Int
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

extension UserResponseDTO {
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
