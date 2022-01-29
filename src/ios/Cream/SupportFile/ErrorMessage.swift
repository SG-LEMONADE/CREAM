//
//  ErrorMessage.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import Foundation

struct ErrorMessage: Decodable {
    let status: Int
    let cod: Int
    let message: String
}
