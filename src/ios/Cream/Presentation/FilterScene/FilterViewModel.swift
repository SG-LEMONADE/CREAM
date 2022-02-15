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
    func didTapSearchButton()
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
    var selectedFilters: Observable<SelectFilter>
    var filterList: [String] = ["카테고리", "브랜드", "성별", "컬렉션"]
    
    var numberOfCells: Int {
        return filterList.count
    }
    
    init(_ usecase: FilterUseCaseInterface, selectedFilters: Observable<SelectFilter>) {
        self.usecase = usecase
        self.selectedFilters = selectedFilters
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
    
    func didTapSearchButton() {
        var brandIds: [Int] = []
        var brandQuery: String? = nil
        
        selectedFilters.value.brands.forEach { selected in
            detailFilters.value.brands.forEach { brand in
                if selected == brand.name {
                    brandIds.append(brand.id)
                }
            }
        }
        if brandIds.isEmpty {
            brandQuery = nil
        } else {
            brandQuery = brandIds.map{ String($0) }.joined(separator: ",")
        }
        NotificationCenter.default.post(name: .filterSearchNotification, object: brandQuery)
    }
}
