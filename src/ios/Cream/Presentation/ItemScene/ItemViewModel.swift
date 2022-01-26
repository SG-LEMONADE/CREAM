//
//  ItemViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import Foundation

class ItemViewModel {
    
    let imageUrls: [String] = ["mock_shoe1", "mock_shoe2", "mock_shoe3"]
    let info: [String] = ["모델 번호", "출시일", "대표색상", "발매가"]
    
    var count: Int {
        return imageUrls.count
    }
    private let Size: [String] = ["255", "260", "270", "275", "280", "290"]
}
