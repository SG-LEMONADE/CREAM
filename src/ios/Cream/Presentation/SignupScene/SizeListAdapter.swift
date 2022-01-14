//
//  SizeListAdapter.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import Foundation

protocol SizeListAdapter: AnyObject {
    var numberOfItems: Int { get }
    func fetchNextItemsIfNeeded(_ indexPath: IndexPath)   
}
