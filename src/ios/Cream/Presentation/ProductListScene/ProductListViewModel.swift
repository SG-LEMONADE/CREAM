//
//  ListViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import Foundation

protocol ProductListViewModelInput {
    func viewDidLoad()
    func didTapProduct(indexPath: IndexPath)
    func didScroll()
    func didTapCategory(indexPath: IndexPath)
    func didDoubleTapCategory(indexPath: IndexPath)
    func didSelectSortOrder(_ sort: String)
    func didSearch(with text: String)
    func didPresentFilterModal()
    func didCancelFilterModal()
    func didFilterRequest(with brandQuery: String?)
}

protocol ProductListViewModelOutput {
    var error: Observable<String> { get }
    var products: Observable<Products> { get set }
    var sortStandard: SortInfo { get set }
    var selectedFilters: Observable<SelectFilter> { get set }
}

protocol ProductListViewModelInterface: ProductListViewModelInput, ProductListViewModelOutput {
    var categories: [String] { get }
    var banners: [String] { get }
}

final class ProductListViewModel: ProductListViewModelInterface {
    private let usecase: ProductUseCaseInterface
    var products: Observable<Products> = Observable([])
    var error: Observable<String> = Observable("")
    var selectedFilters: Observable<SelectFilter> = Observable(.init())
    var currentFilters: SelectFilter?

    private var cursor: Int = .zero
    
    private var searchWord: String?
    private var brandId: String?
    
    var sortStandard: SortInfo = .totalSale
    let banners: [String] = ["banner1", "banner2", "banner3", "banner4", "banner5", "banner6"]
    let categoryFilters = FilterHeaderCategory.allCases.map { $0.description }
    var categories: [String] {
        var filters = ["필터", "럭셔리", " "]
        FilterHeaderCategory.allCases.forEach { filters.append($0.translatedString) }
        return filters
    }
    
    // MARK: Init
    init(_ usecase: ProductUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        searchWord = nil
        selectedFilters.value.category = nil
        print(sortStandard.description)
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: selectedFilters.value.category,
                              sort: sortStandard.description,
                              brandId: brandId) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapCategory(indexPath: IndexPath) {
        selectedFilters.value.category = categoryFilters[indexPath.item-3]
        cursor = .zero

        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: selectedFilters.value.category,
                              sort: sortStandard.description,
                              brandId: brandId) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didDoubleTapCategory(indexPath: IndexPath) {
        selectedFilters.value.category = nil
    }
    
    func didSelectSortOrder(_ sort: String) {
        guard let standard = SortInfo(rawValue: sort)
        else { return }
        
        cursor = .zero
        sortStandard = standard
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: selectedFilters.value.category,
                              sort: sortStandard.description,
                              brandId: brandId) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSearch(with text: String) {
        cursor = .zero
        searchWord = text
        
        let _ = usecase.fetch(page: cursor,
                              searchWord: searchWord,
                              category: selectedFilters.value.category,
                              sort: sortStandard.description,
                              brandId: brandId) { result in
            switch result {
            case .success(let products):
                self.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didPresentFilterModal() {
        currentFilters = selectedFilters.value
    }
    
    func didCancelFilterModal() {
        currentFilters.flatMap {
            selectedFilters.value = $0
        }
        currentFilters = nil
    }
    
    func didTapProduct(indexPath: IndexPath) {
        
    }
    
    func didScroll() {
         
    }

    func didFilterRequest(with brandQuery: String?) {
        cursor = .zero
        brandId = brandQuery
        _ = usecase.fetch(page: cursor,
                          searchWord: nil,
                          category: selectedFilters.value.category,
                          sort: sortStandard.description,
                          brandId: brandId) { [weak self] result in
            switch result {
            case .success(let products):
                self?.products.value = products
            case .failure(let error):
                print(error)
            }
        }
    }
}

enum FilterHeaderCategory: String, CaseIterable {
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
    
    var headerIndexPath: IndexPath {
        switch self {
        case .sneakers:     return .init(item: 3, section: .zero)
        case .streetwear:   return .init(item: 4, section: .zero)
        case .accessories:  return .init(item: 5, section: .zero)
        case .life:         return .init(item: 6, section: .zero)
        case .electronics:  return .init(item: 7, section: .zero)
        }
    }
}
