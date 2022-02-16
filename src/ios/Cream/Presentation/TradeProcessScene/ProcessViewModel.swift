//
//  ProcessViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/04.
//

import Foundation

// MARK: TradeUseCaseInterface
protocol TradeUseCaseInterface {
    
}


// MARK: - TradeUseCase
final class TradeUseCase: TradeUseCaseInterface {
    
}

protocol ProcessViewModelInput {
    func viewDidLoad()
    func didTapInputField()
}

protocol ProcessViewModelOutput {
    var requestPrice: Observable<Int> { get set }
    var selectedProduct: TradeRequest { get set }
    var tradeType: TradeType { get }
    var product: ProductDetail { get }
    var deliveryPrice: Int { get }
}

protocol ProcessViewModelInterface: ProcessViewModelInput, ProcessViewModelOutput {
    
}

final class ProcessViewModel: ProcessViewModelInterface {
    private let usecase: TradeUseCaseInterface
    
    var requestPrice: Observable<Int> = Observable(0)
    var tradeType: TradeType
    var product: ProductDetail
    var selectedProduct: TradeRequest
    var deliveryPrice: Int {
        switch tradeType {
        case .buy:
            return 5_000
        case .sell:
            return 0
        }
    }
    // MARK: Init
    init(_ usecase: TradeUseCaseInterface,
         tradeType: TradeType,
         product: ProductDetail,
         selectedProduct: TradeRequest) {
        self.usecase = usecase
        self.tradeType = tradeType
        self.product = product
        self.selectedProduct = selectedProduct
    }
    
    func viewDidLoad() {
        if let price = selectedProduct.price {
            requestPrice.value = price
        } else {
            requestPrice.value = 0
        }
    }
    
    func didTapInputField() {
        
    }
}
