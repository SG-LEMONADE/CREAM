//
//  TradeViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/01.
//

import Foundation

protocol TradeViewModelInput {
    func didTapSizeCell(indexPath: IndexPath)
    func didTapTradeButton()
}
protocol TradeViewModelOutput {
    var selectSize: Observable<TradeRequest> { get set }
    var sizes: Observable<[String]> { get set }
    var numberOfCells: Int { get }
    var numberOfColumns: Double { get }
    var tradeType: TradeType { get }
    var product: ProductDetail { get }
}

protocol TradeViewModelInterface: TradeViewModelInput, TradeViewModelOutput { }

final class TradeViewModel: TradeViewModelInterface {
    
    var tradeType: TradeType
    var product: ProductDetail
    var selectSize: Observable<TradeRequest> = Observable(.init(size: "", price: nil))
    var sizes: Observable<[String]> = Observable([])
    
    init(tradeType: TradeType, _ product: ProductDetail) {
        self.tradeType = tradeType
        self.product = product
    }
    
    func didTapSizeCell(indexPath: IndexPath) {
        
        let size = product.sizes[indexPath.item]
        let value = tradeType == .buy ? product.askPrices[size] : product.bidPrices[size]
        
        if let optionalPrice = value,
           let price = optionalPrice {
            selectSize.value = .init(size: size,
                                     price: price)
        } else {
            selectSize.value = .init(size: size,
                                     price: nil)
        }
    }
    
    func didTapTradeButton() {
        
    }
}

extension TradeViewModel {
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
