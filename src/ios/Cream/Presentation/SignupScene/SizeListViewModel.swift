//
//  SizeListViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import Foundation

final class SizeListViewModel {
    private var sizeList: [Int]
    
    private var cellViewModels: [SizeListCellViewModel] = [SizeListCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var reloadCollectionViewClosure: (() -> Void)?
    
    init(_ sizeList: [Int] = Array(0...16).map { $0 * 5 + 220}) {
        self.sizeList = sizeList
        fetchViewModel()
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath, completion: @escaping (SizeListCellViewModel) -> Void) {
        completion(cellViewModels[indexPath.row])
    }
    
    func userPressed(at indexPath: IndexPath, completion: @escaping (Int) -> Void) {
        completion(sizeList[indexPath.row])
    }

    func fetchViewModel() {
        var cellViewModels = [SizeListCellViewModel]()
        sizeList.forEach {
            cellViewModels.append(SizeListCellViewModel(sizeText: "\($0)"))
        }
        self.cellViewModels = cellViewModels
    }
}

