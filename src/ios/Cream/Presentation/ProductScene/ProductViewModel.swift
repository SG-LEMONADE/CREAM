//
//  ProductViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation


protocol ProductViewModelInput {
    func viewDidLoad()
    func didTapBuyButton()
    func didTapSellButton()
    func removeFromWishList(size: String)
    func addToWishList(size: String)
    func didSelectItem(size: String)
    var id: Int { get set }
}

protocol ProductViewModelOutput {
    var item: Observable<ProductDetail> { get set }
    var numberOfImageUrls: Int { get }
    var releaseInfo: [(String, String)] { get }
    var numberOfSections: Int { get }
    var selecteSize: Observable<String> { get }
}

protocol ProductViewModelInterface: ProductViewModelInput, ProductViewModelOutput { }

final class ProductViewModel: ProductViewModelInterface {
    private let usecase: ProductUseCaseInterface
    var selecteSize: Observable<String> = .init("")
    var item: Observable<ProductDetail> = Observable(ProductDetail.create())
    var releaseInfo: [(String, String)] {
        var info = [(String, String)]()
        info.append(("모델 번호", item.value.styleCode))
        info.append(("출시일", item.value.releaseDate))
        info.append(("대표색상", item.value.color))
        info.append(("발매가", item.value.originalPrice.priceFormat))
        
        return info
    }
    var id: Int
    var numberOfImageUrls: Int {
        return item.value.imageUrls.count
    }
    
    var numberOfSections: Int {
        return ProductView.SectionList.allCases.count
    }
    
    private var page: Int = 1
    
    init(usecase: ProductUseCaseInterface, id: Int) {
        self.usecase = usecase
        self.id = id
    }
    
    func viewDidLoad() {
        let _ = usecase.fetchItemById(id) { result in
            switch result {
            case .success(let product):
                self.item.value = product
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectItem(size: String) {
        self.selecteSize.value = size
    }
    
    func didTapBuyButton() {
         
    }
    
    func didTapSellButton() {
         
    }
    
    func removeFromWishList(size: String) {
        usecase.addWishList(productId: id, size: size) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addToWishList(size: String) {
        usecase.addWishList(productId: id, size: size) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
