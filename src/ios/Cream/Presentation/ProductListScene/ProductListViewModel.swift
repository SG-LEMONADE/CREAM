//
//  ProductListViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/24.
//

import Foundation

enum Category: String, CaseIterable {
    case slide = "slid"
    case luxury = "럭셔리"
    case blank = " "
    case sneakers = "스니커즈"
    case clothes = "의류"
    case accessory = "패션 잡화"
    case life = "라이프"
    case tech = "테크"
}

class ProductListViewModel: NSObject {
    var reloadCollectionView: (() -> Void)?
//    let categories = Category.allCases
    let categories = ["필터", "럭셔리", " ", "스니커즈", "의류", "패션 잡화", "라이프", "테크"]
    let banners: [String] = ["banner1", "banner2", "banner3", "banner4", "banner5", "banner6"]
    
    var products: Products = Products()
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var productCellViewModel: Observable<[ProductCellViewModel]> = Observable([])
    
    func fetchData(products: Products) {
        self.products = products // Cache
        var viewModels = [ProductCellViewModel]()
        for item in products {
            viewModels.append(createCellModel(product: item))
        }
    }
    
    func createCellModel(product: Product) -> ProductCellViewModel {
        return ProductCellViewModel(totalSale: "\(product.productInfo.totalSale)",
                                    brandName: product.productInfo.brandName,
                                    originalName: product.productInfo.originalName,
                                    backgroundColor: product.productInfo.backgroundColor,
                                    imageUrls: product.productInfo.imageUrls,
                                    wishList: product.wishList,
                                    lowestAsk: "\(product.lowestAsk)",
                                    wishCount: "\(product.productInfo.wishCount)")
    }
}
