//
//  AuthResponseDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct AuthResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let userId: Int
}

extension AuthResponseDTO {
    func toDomain() -> Auth {
        return Auth(accessToken: self.accessToken,
                    refreshToken: self.refreshToken)
    }
}
