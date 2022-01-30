//
//  SizeListViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import Foundation

protocol SizeListViewModelInput {
    var sizeList: [String] { get set }
    func didSelectSize(at indexPath: IndexPath, completion: @escaping (String) -> Void)
}

protocol SizeListViewModelOutput {
    var size: Observable<String> { get set }
    var numberOfCells: Int { get }
    var reloadCollectionViewClosure: (() -> Void)? { get set }
    func getCellViewModel(at indexPath: IndexPath, completion: @escaping (SizeListCellViewModel) -> Void)
}

protocol SizeListViewModel: SizeListViewModelInput, SizeListViewModelOutput { }

final class DefaultSizeListViewModel: SizeListViewModel {
    
    var size: Observable<String> = Observable("")
    var sizeList: [String]
    
    var reloadCollectionViewClosure: (() -> Void)?
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    private var cellViewModels: [SizeListCellViewModel] = [SizeListCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    init(_ sizeList: [String] = Array(0...16).map { "\($0 * 5 + 220)" }) {
        self.sizeList = sizeList
        self.fetchViewModel()
    }
    
    func getCellViewModel(at indexPath: IndexPath, completion: @escaping (SizeListCellViewModel) -> Void) {
        completion(cellViewModels[indexPath.row])
    }
    
    func didSelectSize(at indexPath: IndexPath, completion: @escaping (String) -> Void) {
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

