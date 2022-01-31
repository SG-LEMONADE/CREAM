//
//  APIEndpoints.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct APIEndpoints {

    // MARK: - User
    static func confirmUser(with authRequestDTO: AuthRequestDTO) -> Endpoint<AuthResponseDTO> {
        return Endpoint(path: "users/login",
                        method: .post,
                        headerParamaters: ["Content-Type":"application/json"],
                        bodyParamatersEncodable: authRequestDTO)
    }
    
    static func addUser(with joinRequestDTO: JoinRequestDTO) -> Endpoint<JoinResponseDTO> {
        return Endpoint(path: "users/signup",
                        method: .post,
                        headerParamaters: ["Content-Type":"application/json"],
                        bodyParamatersEncodable: joinRequestDTO)
    }
    
    // MARK: - Product
    static func loadProduct(_ id: Int) -> Endpoint<ProductResponseDTO> {
        // TODO: AccessToken이 있다면, header에 해당 값 넣기
        return Endpoint(path: "products/\(id)",
                        method: .get,
                        headerParamaters: ["Content-Type":"application/json"])
    }
    
    static func loadProducts(_ page: Int) -> Endpoint<[ProductInfoResponseDTO]> {
        return Endpoint(path: "products",
                        method: .get,
                        headerParamaters: ["Content-Type":"application/json"],
                        queryParameters: ["cursor": page,
                                          "perPage": 40])
    }
    
}
