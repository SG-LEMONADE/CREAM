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
    var id: Int { get set }
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
    var releaseInfo: [(String, String)] {
        var info = [(String, String)]()
        info.append(("모델 번호", item.value.styleCode))
        info.append(("출시일", item.value.releaseDate))
        info.append(("대표색상", item.value.color))
        info.append(("발매가", item.value.originalPrice.priceFormat))
        
        return info
    }
    var id: Int = 0
    var count: Int {
        return item.value.imageUrls.count
    }
    
    private var page: Int = 1
    
    init(usecase: ProductUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        usecase.fetchItemById(id) { result in
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
