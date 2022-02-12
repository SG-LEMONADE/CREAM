//
//  APIEndpoints.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation
import SwiftKeychainWrapper

struct APIEndpoints {
    // MARK: - Home API
    static func loadHome() -> Endpoint<HomeResponseDTO> {
        return Endpoint(path: "",
                        method: .get,
                        headerParamaters: ["Content-Type":"application/json"])
    }
    
    // MARK: - User API
    static func confirmUser(with authRequestDTO: AuthRequestDTO) -> Endpoint<AuthResponseDTO> {
        return Endpoint(path: "users/login",
                        method: .post,
                        headerParamaters: ["Content-Type":"application/json"],
                        bodyParamatersEncodable: authRequestDTO)
    }
    
    static func addUser(with joinRequestDTO: JoinRequestDTO) -> Endpoint<JoinResponseDTO> {
        return Endpoint(path: "users/join",
                        method: .post,
                        headerParamaters: ["Content-Type":"application/json"],
                        bodyParamatersEncodable: joinRequestDTO)
    }
    
    static func verifyToken() -> Endpoint<Void> {
        var headerParameters: [String: String] = ["Content-Type":"application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: "users/validate",
                        method: .post,
                        headerParamaters: headerParameters)
    }
    
    static func removeToken() -> Endpoint<Void> {
        var headerParameters: [String: String] = ["Content-Type":"application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: "users/logout",
                        method: .post,
                        headerParamaters: headerParameters)
    }
    
    static func reissueToken() -> Endpoint<AuthResponseDTO> {
        var bodyParameters: [String: Any] = [:]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)"}
            .flatMap {
                bodyParameters.updateValue($0, forKey: KeychainWrapper.Key.accessToken)
            }
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.refreshToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                bodyParameters.updateValue($0, forKey: KeychainWrapper.Key.refreshToken)
            }
        
        return Endpoint(path: "users/refresh",
                        method: .post,
                        headerParamaters: ["Content-Type":"application/json"],
                        bodyParamaters: bodyParameters)
    }
    
    // MARK: - Product API
    static func loadProduct(_ id: Int) -> Endpoint<ProductResponseDTO> {
        // TODO: AccessToken이 있다면, header에 해당 값 넣기
        return Endpoint(path: "products/\(id)",
                        method: .get,
                        headerParamaters: ["Content-Type":"application/json"])
    }
    
    static func loadProducts(_ page: Int,
                             searchWord: String?,
                             category: String?,
                             sort: String?) -> Endpoint<[ProductInfoResponseDTO]> {
        var queryParameters: [String: Any] = ["cursor": page,
                                              "perPage": 20]
        _ = searchWord.flatMap {
            queryParameters.updateValue($0, forKey: "keyword")
        }
        _ = category.flatMap {
            queryParameters.updateValue($0, forKey: "category")
        }
        _ = sort.flatMap {
            queryParameters.updateValue($0, forKey: "sort")
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
