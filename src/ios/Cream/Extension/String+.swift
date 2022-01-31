//
//  String+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import Foundation

extension String {
    var hexToInt: Int? {
        return Int(self, radix: 16)
    }
}
