//
//  User.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import Foundation

// MARK: User
struct UserEntity: Codable {
    let address: String
    let age: Int
    let createdAt, email: String
    let gender: Bool
    let id: Int
    let lastLoginDateTime: String
    let name: String
    let passwordChangedDateTime: String
    let profileImageUrl: String
    let shoeSize, status: Int
    let updatedAt: String
}
