//
//  ItemViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import Foundation

class ItemViewModel {
    
    let imageUrls: [String] = ["mock_shoe1", "mock_shoe2", "mock_shoe3"]
    
    var count: Int {
        return imageUrls.count
    }
    private let Size: [String] = ["255", "260", "270", "275", "280", "290"]
}
