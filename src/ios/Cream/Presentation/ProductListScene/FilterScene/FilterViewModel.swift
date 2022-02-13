//
//  FilterViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/09.
//

import Foundation

// MARK: - ViewModel
protocol FilterViewModelInput {
    func viewDidLoad()
}

protocol FilterViewModelOutput {
    var products: Observable<Products> { get set }
    var filterKind: [String] { get set }
    var filter: Observable<Filter> { get set }
    var numberOfCells: Int { get }
}

protocol FilterViewModelInterface: FilterViewModelInput, FilterViewModelOutput { }

final class FilterViewModel: FilterViewModelInterface {
    
    var products: Observable<Products> = Observable([])
    var filterKind: [String] = ["카테고리", "브랜드", "성별", "컬렉션"]
    var filter: Observable<Filter> = Observable(.init(categories: [],
                                                      brands: [],
                                                      collections: [],
                                                      gender: []))
    
    var numberOfCells: Int {
        return filterKind.count
    }
    
    private let usecase: FilterUseCaseInterface
    
    init(_ usecase: FilterUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        // TODO: Load FilterCases
        _ = usecase.fetchFilter { result in
            switch result {
            case .success(let filter):
                print(filter)
                self.filter.value = filter
            case .failure(_):
                break
            }
        }
    }
}
