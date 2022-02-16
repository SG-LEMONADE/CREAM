//
//  Int+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/10.
//

import Foundation

extension Int {
    static let one = 1
    
    func caculateDeadLine() -> String {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = self
        
        guard let expiredDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return "\(self)일 (\(dateFormatter.string(from: expiredDate)) 마감)"
    }
}
