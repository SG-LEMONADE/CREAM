//
//  APIEndpoints.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct APIEndpoints {
    // MARK: - Home
    static func loadHome() -> Endpoint<HomeResponseDTO> {
        return Endpoint(path: "",
                        method: .get,
                        headerParamaters: ["Content-Type":"application/json"])
    }
    
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
    
    static func loadProducts(_ page: Int, category: String?,
                             sort: String?) -> Endpoint<[ProductInfoResponseDTO]> {
        var queryParameters: [String: Any] = ["cursor": page,
                                              "perPage": 20]
        _ = category.flatMap {
            queryParameters.updateValue($0, forKey:"category")
        }
        _ = sort.flatMap {
            queryParameters.updateValue($0, forKey:"sort")
        }
        
        return Endpoint(path: "products",
                        method: .get,
                        headerParamaters: ["Content-Type":"application/json"],
                        queryParameters: queryParameters)
    }
    
    static func addToWishList(id: Int, size: String) -> Endpoint<Void> {
        let queryParameters: [String: Any] = ["id": id,
                                              "size": size]
        return Endpoint(path: "wish",
                        method: .post,
                        headerParamaters: ["Content-Type":"application/json"],
                        queryParameters: queryParameters)
    }
}
