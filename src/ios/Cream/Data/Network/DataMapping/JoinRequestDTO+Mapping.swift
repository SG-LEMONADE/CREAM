//
//  JoinRequestDTO+Mapping.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import Foundation

struct JoinRequestDTO: Encodable {
    let email: String
    let password: String
    let shoesize: Int
}
