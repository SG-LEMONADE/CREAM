//
//  ListViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import Foundation
import Accelerate

protocol ProductListViewModelInput {
    func viewDidLoad()
    func didTapProduct(indexPath: IndexPath)
    func didScroll()
    func didTapCategory(indexPath: IndexPath)
    func didSelectSortOrder(_ sort: String)
    func didSearch(with text: String)
}

protocol ProductListViewModelOutput {
    var error: Observable<String> { get }
    var products: Observable<Products> { get set }
    var sortStandard: SortInfo { get set }
}

protocol ProductListViewModel: ProductListViewModelInput, ProductListViewModelOutput {
    var categories: [String] { get }
    var banners: [String] { get }
}

final class DefaultListViewModel: ProductListViewModel {
    var usecase: ProductUseCaseInterface
    var products: Observable<Products> = Observable([])
    var error: Observable<String> = Observable("")
    
    enum FilterCategory: String, CaseIterable {
        case sneakers
        case streetwear
        case accessories
        case life
        case electronics
        
        var description: String {
            rawValue
        }
        
        var translatedString: String {
            switch self {
            case .sneakers:     return "스니커즈"
            case .streetwear:   return "의류"
            case .accessories:  return "패션 잡화"
            case .life:         return "라이프"
            case .electronics:  return "테크"
            }
        }
    }
    private var selectedCategory: String?
    private var cursor = 1
    private var category: String?
    private var searchWord: String?
    
    var sortStandard: SortInfo = .totalSale
    let banners: [String] = ["banner1", "banner2", "banner3", "banner4", "banner5", "banner6"]
    let categoryFilters = FilterCategory.allCases.map { $0.description }
    var categories: [String] {
        var filters = ["필터", "럭셔리", " "]
        FilterCategory.allCases.forEach { filters.append($0.translatedString) }
        return filters
    }
    
    // MARK: Init
    init(_ usecase: ProductUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        searchWord = nil
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: category,
                              sort: sortStandard.description) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapCategory(indexPath: IndexPath) {
        cursor = .one
        category = categoryFilters[indexPath.item-3]
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: category,
                              sort: sortStandard.description) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectSortOrder(_ sort: String) {
        guard let standard = SortInfo(rawValue: sort)
        else { return }
        
        cursor = .one
        sortStandard = standard
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: category,
                              sort: sortStandard.description) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSearch(with text: String) {
        cursor = .one
        searchWord = text
        
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: category,
                              sort: sortStandard.description) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapProduct(indexPath: IndexPath) {
        
    }
    
    func didScroll() {
         
    }
}
