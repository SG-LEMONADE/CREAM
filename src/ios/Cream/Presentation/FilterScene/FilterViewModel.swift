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
    var filterList: [String] { get set }
    var detailFilters: Observable<Filter> { get set }
    var selectedFilters: Observable<SelectFilter> { get set }
    var numberOfCells: Int { get }
}

protocol FilterViewModelInterface: FilterViewModelInput, FilterViewModelOutput { }

final class FilterViewModel: FilterViewModelInterface {
    private let usecase: FilterUseCaseInterface
    var detailFilters: Observable<Filter> = Observable(.init(categories: [],
                                                      brands: [],
                                                      collections: [],
                                                      gender: []))
    var selectedFilters: Observable<SelectFilter> = Observable(.init())
    var filterList: [String] = ["카테고리", "브랜드", "성별", "컬렉션"]
    
    var numberOfCells: Int {
        return filterList.count
    }
    
    init(_ usecase: FilterUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        // TODO: Load FilterCases
        _ = usecase.fetchFilter { result in
            switch result {
            case .success(let filter):
                self.detailFilters.value = filter
            case .failure(_):
                break
            }
        }
    }
}
