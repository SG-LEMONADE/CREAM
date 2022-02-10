//
//  ErrorMessage.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import Foundation

public struct ErrorMessage: Decodable {
    let status: Int
    let code: Int
    let message: String
}
