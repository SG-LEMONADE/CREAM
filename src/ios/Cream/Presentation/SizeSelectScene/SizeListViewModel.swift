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
    func getCellViewModel(at indexPath: IndexPath, completion: @escaping (String) -> Void)
}

protocol SizeListViewModel: SizeListViewModelInput, SizeListViewModelOutput { }

final class DefaultSizeListViewModel: SizeListViewModel {
    var size: Observable<String> = Observable("")
    var sizeList: Observable<[String]> = Observable([])

    var numberOfCells: Int {
        return sizeList.value.count
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
