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
}

protocol ProductListViewModelOutput {
    var error: Observable<String> { get }
    var products: Observable<Products> { get set }
}

protocol ProductListViewModel: ProductListViewModelInput, ProductListViewModelOutput {
    var usecase: ProductUseCaseInterface { get }
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
    
    var page = 1
    var categories: [String] {
        var filters = ["필터", "럭셔리", " "]
        FilterCategory.allCases.forEach { filters.append($0.translatedString) }
        return filters
    }
    
    let categoryFilters = FilterCategory.allCases.map { $0.description }
    
    let banners: [String] = ["banner1", "banner2", "banner3", "banner4", "banner5", "banner6"]
    

    
    
    init(_ usecase: ProductUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        let _ = usecase.fetch(page: page, category: nil) { result in
            switch result {
            case .success(let products):
                self.products.value.append(contentsOf: products)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapCategory(indexPath: IndexPath) {
        print(indexPath)
        let _ = usecase.fetch(page: page, category: nil) { result in
            switch result {
            case .success(let products):
                self.products.value.removeAll()
                self.products.value.append(contentsOf: products)
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
