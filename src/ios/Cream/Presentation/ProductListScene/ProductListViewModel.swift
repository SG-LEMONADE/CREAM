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
    
    private var page = 1
    
    let categories = ["필터", "럭셔리", " ", "스니커즈", "의류", "패션 잡화", "라이프", "테크"]
    let banners: [String] = ["banner1", "banner2", "banner3", "banner4", "banner5", "banner6"]
    
    init(_ usecase: ProductUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        let _ = usecase.fetch(page: page) { result in
            switch result {
            case .success(let products):
                print(products)
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
