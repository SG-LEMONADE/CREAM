//
//  ProductViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation
import Charts

protocol ProductViewModelInput {
    func viewDidLoad()
    func didTapWishButton()
    func didTapSizeButton()
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
    var selectSize: Observable<String> { get }
    var chartData: [[ChartDataEntry]] { get set }
    var selectedPeriod: Observable<Int> { get set }
    var selections: Observable<[SelectionType]> { get set }
    var isDidLoad: Bool { get set }
    var isClickedWishButton: Bool { get set }
}

protocol ProductViewModelInterface: ProductViewModelInput, ProductViewModelOutput { }

final class ProductViewModel: ProductViewModelInterface {
    private let usecase: ProductUseCaseInterface
    var isDidLoad: Bool = false
    var selectSize: Observable<String> = .init("")
    var item: Observable<ProductDetail> = Observable(ProductDetail.create())
    var chartData: [[ChartDataEntry]] = []
    var selections: Observable<[SelectionType]> = .init([])
    var selectedPeriod: Observable<Int> = .init(0)
    var id: Int
    var isClickedWishButton: Bool = false
    
    var numberOfImageUrls: Int {
        return item.value.imageUrls.count
    }
    
    var numberOfSections: Int {
        return ProductView.SectionList.allCases.count
    }
    
    var releaseInfo: [(String, String)] {
        var info = [(String, String)]()
        info.append(("모델 번호", item.value.styleCode))
        info.append(("출시일", item.value.releaseDate))
        info.append(("대표색상", item.value.color))
        info.append(("발매가", item.value.originalPrice.priceFormat))
        return info
    }
        
    
    // MARK: - init
    init(usecase: ProductUseCaseInterface, id: Int) {
        self.usecase = usecase
        self.id = id
    }
    
    
    // MARK: - view life cycle
    func viewDidLoad() {
        usecase.fetchItemById(self.id, size: nil) { result in
            switch result {
            case .success(let product):
                let size: String? = self.selectSize.value != "" ? self.selectSize.value : nil
                let _ = self.usecase.fetchPrice(id: self.id, size: size) { result in
                    switch result {
                    case .success(let chartData):
                        self.chartData = self.converToChartData(list: chartData)
                        self.item.value = product
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapWishButton() {
        isClickedWishButton = true
    }
    
    func didSelectItem(size: String) {
        usecase.fetchItemById(id, size: size) { result in
            switch result {
            case .success(let product):
                self.item.value = product
                self.selectSize.value = size
            case .failure(let error):
                print(error)
            }
        }
        
        usecase.fetchPrice(id: id, size: size) { result in
            switch result {
            case .success(let product):
                self.chartData = self.converToChartData(list: product)
            case .failure(let error):
                print(error)
            }
        }
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
    
    func didTapSizeButton() {
        let askPrices = item.value.askPrices
        
        var items: [SelectionType] = []
        item.value.sizes.forEach {
            if let _price = askPrices[$0] {
                if let price = _price {
                    items.append(SelectionType.sizePrice(size: $0, price: price))
                } else {
                    items.append(SelectionType.sizePrice(size: $0, price: nil))
                }
            } else {
                items.append(SelectionType.sizePrice(size: $0, price: nil))
            }
        }
        selections.value = items
    }
    private func converToChartData(list: [[PriceList]]) -> [[ChartDataEntry]] {
        var entries: [[ChartDataEntry]] = []
        let period: [Int] = [30, 90, 180, 365, 365]
        for (index, entry) in list.enumerated() {
            if entry.isEmpty {
                var batchEntries: [ChartDataEntry] = []
                for i in 0..<period[index] {
                    batchEntries.append(.init(x: Double(i), y: 0))
                }
                entries.append(batchEntries)
            } else {
                var batchEntries: [ChartDataEntry] = []
                for i in (0..<period[index] - entry.count) {
                    batchEntries.append(.init(x: Double(i), y: 0))
                }
                let nextIndex = period[index] - entry.count
                for (batchIndex, date) in entry.enumerated() {
                    batchEntries.append(.init(x: Double(batchIndex + nextIndex), y: Double(date.price)))
                }
                entries.append(batchEntries)
            }
        }
        return entries
    }
}
