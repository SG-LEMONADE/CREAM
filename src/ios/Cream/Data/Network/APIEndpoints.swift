//
//  APIEndpoints.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct APIEndpoints {

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
    
}
