//
//  ProductViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation


protocol ProductViewModelInput {
    func viewDidLoad()
    func didTapWishButton()
    func didTapBuyButton()
    func didTapSellButton()
}

protocol ProductViewModelOutput {
    var item: Observable<ProductDetail> { get set }
    var count: Int { get }
    var releaseInfo: [(String, String)] { get }
}

protocol ProductViewModel: ProductViewModelInput, ProductViewModelOutput {
    var usecase: ProductUseCaseInterface { get set }
}

final class DefaultProductViewModel: ProductViewModel {
    var usecase: ProductUseCaseInterface
    
    var item: Observable<ProductDetail> = Observable(ProductDetail.create())

    let imageUrls: [String] = ["mock_shoe1", "mock_shoe2", "mock_shoe3"]
    
    var releaseInfo: [(String, String)] {
        var info = [(String, String)]()
        info.append(("모델 번호", item.value.styleCode))
        info.append(("출시일", item.value.releaseDate))
        info.append(("대표색상", item.value.color))
        info.append(("발매가", item.value.originalPrice.priceFormat))
        
        return info
    }
    private var page: Int = 1
    
    var count: Int {
        return imageUrls.count
    }
    
    init(usecase: ProductUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        usecase.fetchItemById(2351) { result in
            switch result {
            case .success(let product):
                self.item.value = product
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapWishButton() {
         
    }
    
    func didTapBuyButton() {
         
    }
    
    func didTapSellButton() {
         
    }
}
