//
//  SizeListViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import Foundation

protocol SizeListViewModelInput {
    var sizeList: Observable<[String]> { get set }
    func viewDidLoad()
    func didSelectSize(at indexPath: IndexPath, completion: @escaping (String) -> Void)
}

protocol SizeListViewModelOutput {
    var size: Observable<String> { get set }
    var numberOfCells: Int { get }
    var numberOfColumns: Double { get }
    func getCellViewModel(at indexPath: IndexPath, completion: @escaping (String) -> Void)
}

protocol SizeListViewModelInterface: SizeListViewModelInput, SizeListViewModelOutput { }

final class SizeListViewModel: SizeListViewModelInterface {
    var size: Observable<String> = Observable("")
    var sizeList: Observable<[String]> = Observable([])
    
    var numberOfCells: Int {
        return sizeList.value.count
    }
    
    var numberOfColumns: Double {
        if sizeList.value.count < 4 {
            return 1
        } else if sizeList.value.count < 13 {
            return 3
        } else {
            return 2
        }
    }

    init(_ sizeList: [String] = Array(0...16).map { "\($0 * 5 + 220)" }) {
        self.sizeList.value = sizeList
    }
    
    func getCellViewModel(at indexPath: IndexPath, completion: @escaping (String) -> Void) {
        completion(sizeList.value[indexPath.row])
    }
    
    func didSelectSize(at indexPath: IndexPath, completion: @escaping (String) -> Void) {
        completion(sizeList.value[indexPath.row])
    }
    
    func viewDidLoad() {
        
    }
}
