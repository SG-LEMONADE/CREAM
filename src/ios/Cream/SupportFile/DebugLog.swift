//
//  DebugLog.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import Foundation

public func myLogPrint(_ object: Any, filename: String = #file, _ line: Int = #line, _ funcname: String = #function) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss:SSS"
    print("Wanki's Log : \(dateFormatter.string(from: Date())) file: \(filename) line: \(line) func: \(funcname)")
    print(object)
}
