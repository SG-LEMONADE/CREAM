//
//  HTTPMethod.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, petch, delete
    
    var type: String {
        self.rawValue.uppercased()
    }
}
