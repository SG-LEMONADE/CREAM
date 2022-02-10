//
//  String+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import Foundation

extension String {
    var hexToInt: Int? {
        let hexString = self.replacingOccurrences(of: "#", with: "")
        return Int(hexString, radix: 16)
    }
}
