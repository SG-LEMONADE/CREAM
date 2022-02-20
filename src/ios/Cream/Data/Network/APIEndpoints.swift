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
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: "",
                        method: .get,
                        headerParamaters: headerParameters)
    }
    
    // MARK: - User API
    static func confirmUser(with authRequestDTO: AuthRequestDTO) -> Endpoint<AuthResponseDTO> {
        return Endpoint(path: "users/login",
                        method: .post,
                        headerParamaters: ["Content-Type": "application/json"],
                        bodyParamatersEncodable: authRequestDTO)
    }
    
    static func addUser(with joinRequestDTO: JoinRequestDTO) -> Endpoint<JoinResponseDTO> {
        return Endpoint(path: "users/join",
                        method: .post,
                        headerParamaters: ["Content-Type": "application/json"],
                        bodyParamatersEncodable: joinRequestDTO)
    }
    
    static func verifyToken() -> Endpoint<Void> {
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: "users/validate",
                        method: .get,
                        headerParamaters: headerParameters)
    }
    
    static func removeToken() -> Endpoint<Void> {
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: "users/logout",
                        method: .post,
                        headerParamaters: headerParameters)
    }
    
    static func fetchUserInfo() -> Endpoint<UserResponseDTO> {
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: "users/me",
                        method: .get,
                        headerParamaters: headerParameters)
    }
    
    static func reissueToken() -> Endpoint<AuthResponseDTO> {
        var bodyParameters: [String: Any] = [:]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.refreshToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                bodyParameters.updateValue($0, forKey: KeychainWrapper.Key.refreshToken)
            }
        return Endpoint(path: "users/refresh",
                        method: .post,
                        headerParamaters: ["Content-Type": "application/json"],
                        bodyParamaters: bodyParameters)
    }
    
    // MARK: - Product API
    static func loadProduct(_ id: Int, size: String?) -> Endpoint<ProductResponseDTO> {
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        var path = "products/\(id)"
        
        if let size = size,
           let sizeQuery = size.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            path += "/\(sizeQuery)"
        }

        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        return Endpoint(path: path,
                        method: .get,
                        headerParamaters: headerParameters)
    }
    
    static func loadProducts(_ cursor: Int,
                             searchWord: String?,
                             category: String?,
                             sort: String?,
                             brandId: String?) -> Endpoint<[ProductInfoResponseDTO]> {
        
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        var queryParameters: [String: Any] = ["cursor": cursor,
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
        _ = brandId.flatMap {
            queryParameters.updateValue($0, forKey: "brandId")
        }
        
        return Endpoint(path: "products",
                        method: .get,
                        headerParamaters: headerParameters,
                        queryParameters: queryParameters)
    }
    
    // MARK: - Filter API
    static func loadFilter() -> Endpoint<FilterResponseDTO> {
        return Endpoint(path: "filters",
                        method: .get,
                        headerParamaters: ["Content-Type": "application/json"])
    }
    
    // MARK: - Trade API
    static func fetchTradeInfo(type: TradeType) -> Endpoint<TradeResponseDTO> {
        var headerParameters: [String: String] = ["Content-Type": "application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        let queryParameters: [String: Any] = ["cursor": 0,
                                              "perPage": 100,
                                              "requestType": type.requestString,
                                              "tradeStatus": "ALL"]
        return Endpoint(path: "trades",
                        method: .get,
                        headerParamaters: headerParameters,
                        queryParameters: queryParameters)
    }
    
    static func requestTrade(tradeType: TradeType,
                             productId: Int,
                             size: String,
                             price: Int,
                             validate: Int?) -> Endpoint<Void> {
        
        var headerParameters: [String: String] = ["Content-Type":"application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        let safeString = size.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let validateDay = validate {
            let bodyParameters: [String: Any] = ["price": price,
                                                 "requestType": tradeType.requestString,
                                                 "validationDay": validateDay]
            
            return Endpoint(path: "trades/products/\(productId)/\(safeString!)",
                            method: .post,
                            headerParamaters: headerParameters,
                            bodyParamaters: bodyParameters)
        }
        return Endpoint(path: "trades/\(tradeType.rawValue)/select/\(productId)/\(safeString!)",
                        method: .post,
                        headerParamaters: headerParameters)
    }
    
    static func fetchPrice(id: Int,
                           size: String?) -> Endpoint<PriceResponseDTO> {
        var headerParameters: [String: String] = ["Content-Type":"application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        if let size = size,
           let safeString = size.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return Endpoint(path: "prices/products/\(id)/\(safeString)",
                            method: .get,
                            headerParamaters: headerParameters)
        } else {
            return Endpoint(path: "prices/products/\(id)",
                            method: .get,
                            headerParamaters: headerParameters)
        }
    }
    
    // MARK: - Wish API
    static func addToWishList(productId: Int,
                              size: String) -> Endpoint<Void> {
        var headerParameters: [String: String] = ["Content-Type":"application/json"]
        
        _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken)
            .map { "Bearer-\($0)" }
            .flatMap {
                headerParameters.updateValue($0, forKey: "Authorization")
            }
        
        let safeString = size.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return Endpoint(path: "wish/\(productId)/\(safeString!)",
                        method: .post,
                        headerParamaters: headerParameters)
    }
}
