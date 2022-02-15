//
//  DetailFilterViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

protocol DetailFilterViewModelInput {
    func reinitSelected()
    func didSelectRowAt(indexPath: IndexPath)
    func didDeselectRowAt(indexPath: IndexPath)
    func didTapSearchButton()
}
protocol DetailFilterViewModelOutput {
    var type: FilterCategory { get }
    var filter: [String] { get }
    var totalFilters: Filter { get set }
    var selectedList: Observable<SelectFilter> { get set }
}

protocol DetailFilterViewModelInterface: DetailFilterViewModelInput, DetailFilterViewModelOutput { }

final class DetailFilterViewModel: DetailFilterViewModelInterface {
    private let usecase: ProductUseCaseInterface
    var totalFilters: Filter
    let filter: [String]
    let type: FilterCategory
    var selectedList: Observable<SelectFilter> = Observable(.init())
    
    init(usecase: ProductUseCaseInterface,
         filter: [String],
         type: FilterCategory,
         totalFilter: Filter,
         selectedList: Observable<SelectFilter>) {
        self.usecase = usecase
        self.filter = filter
        self.type = type
        self.totalFilters = totalFilter
        self.selectedList = selectedList
    }
    
    func reinitSelected() {
        switch self.type {
        case .category:
            selectedList.value.category = nil
        case .brand:
            selectedList.value.brands = []
        case .gender:
            selectedList.value.gender = nil
        case .collection:
            selectedList.value.collections = []
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        switch type {
        case .category:
            selectedList.value.category = filter[indexPath.row]
        case .brand:
            selectedList.value.brands.append(filter[indexPath.row])
        case .gender:
            selectedList.value.gender = filter[indexPath.row]
        case .collection:
            selectedList.value.collections.append(filter[indexPath.row])
        }
    }
    
    func didDeselectRowAt(indexPath: IndexPath) {
        switch type {
        case .category:
            selectedList.value.category = nil
        case .brand:
            selectedList.value.brands.removeAll(where: { $0 == filter[indexPath.row]})
        case .gender:
            selectedList.value.gender = nil
        case .collection:
            selectedList.value.collections.removeAll(where: { $0 == filter[indexPath.row]})
        }
    }
    
    func didTapSearchButton() {
        var brandIds: [Int] = []
        var brandQuery: String? = nil
        
        selectedList.value.brands.forEach { selected in
            totalFilters.brands.forEach { brand in
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


