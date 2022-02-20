//
//  ProcessViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/04.
//

import Foundation

protocol ProcessViewModelInput {
    func viewDidLoad()
    func didTapTradeButton()
    func didSelectDeadline(_ deadline: Int)
}

protocol ProcessViewModelOutput {
    var requestPrice: Observable<Int> { get set }
    var selectedProduct: TradeRequest { get set }
    var tradeResult: Observable<Bool> { get }
    var tradeAvailable: Observable<Bool> { get }
    var tradeType: TradeType { get }
    var product: ProductDetail { get }
    var deliveryPrice: Int { get }
    var deliveryInfo: String { get }
    var validateDay: Observable<Int?> { get set }
    var deadLines: [Int] { get }
}

protocol ProcessViewModelInterface: ProcessViewModelInput, ProcessViewModelOutput { }

final class ProcessViewModel: ProcessViewModelInterface {
    private let usecase: TradeUseCaseInterface
    
    var tradeResult: Observable<Bool> = .init(false)
    var validateDay: Observable<Int?> = .init(30)
    var requestPrice: Observable<Int> = .init(0)
    var tradeType: TradeType
    var product: ProductDetail
    var selectedProduct: TradeRequest
    var deadLines: [Int] = ValidateDeadLine.allCases.map { $0.rawValue }
    var tradeAvailable: Observable<Bool> = .init(false)
    enum ValidateDeadLine: Int, CaseIterable {
        case one = 1
        case third = 3
        case week = 7
        case month = 30
        case quarter = 90
    }
    
    var deliveryInfo: String {
        if tradeType == .buy {
            return deliveryPrice.priceFormatWithUnit
        } else {
            return "선불﹒판매자 부담"
        }
    }
    
    var deliveryPrice: Int {
        switch tradeType {
        case .buy:
            return 5_000
        case .sell:
            return 0
        }
    }
    
    // MARK: init
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
        checkTradeAvailable()
        if let price = selectedProduct.price {
            requestPrice.value = price
        } else {
            requestPrice.value = 0
        }
    }
    
    func didTapTradeButton() {
        if let price = selectedProduct.price,
           price == requestPrice.value {
            validateDay.value = nil
        }
        _ = usecase.requestTrade(tradeType: tradeType,
                                 productId: product.id,
                                 size: selectedProduct.size,
                                 price: requestPrice.value,
                                 validate: validateDay.value) { result in
            switch result {
            case .success(_):
                self.tradeResult.value = true
            case .failure(let error):
                self.tradeResult.value = false
            }
        }
    }
    
    func didSelectDeadline(_ deadline: Int) {
        validateDay.value = deadline
    }
    
    private func checkTradeAvailable() {
        if selectedProduct.price == nil {
            tradeAvailable.value = true
        } else {
            tradeAvailable.value = false
        }
    }
}
