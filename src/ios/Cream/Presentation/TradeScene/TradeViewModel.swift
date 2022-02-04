//
//  TradeViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/01.
//

import Foundation

protocol TradeViewModelInput {
    var tradeType: TradeType { get }
    var product: ProductDetail { get }
    func didTapSizeCell(indexPath: IndexPath)
    func didTapTradeButton()
}

protocol TradeViewModelOutput {
    var selectSize: Observable<(size: String, price: String?)> { get set }
    var sizes: Observable<[String]> { get set }
    var numberOfCells: Int { get }
    var numberOfColumns: Double { get }
    func willTransferToPayScene()
}

protocol TradeViewModel: TradeViewModelInput, TradeViewModelOutput { }

final class DefaultTradeViewModel: TradeViewModel {
    
    var tradeType: TradeType
    var product: ProductDetail
    
    var selectSize: Observable<(size: String, price: String?)> = Observable((size: "", price: nil))
    var sizes: Observable<[String]> = Observable([])
    
    init(tradeType: TradeType, _ product: ProductDetail) {
        self.tradeType = tradeType
        self.product = product
    }
    
    func willTransferToPayScene() {
        
    }
    
    func didTapSizeCell(indexPath: IndexPath) {
        let size = product.sizes[indexPath.item]
        let value = product.askPrices[size]
        if let optionalPrice = value,
            let price = optionalPrice {
            selectSize.value = (size: size, price: price.priceFormat)
        } else {
            selectSize.value = (size: size, price: String(describing: tradeType.description + "입찰"))
        }
    }
    
    func didTapTradeButton() {
        
    }
}

extension DefaultTradeViewModel {
    var numberOfCells: Int {
        return product.sizes.count
    }
    
    var numberOfColumns: Double {
        if product.sizes.count < 4 {
            return 1
        } else if sizes.value.count < 13 {
            return 3
        } else {
            return 2
        }
    }
}
