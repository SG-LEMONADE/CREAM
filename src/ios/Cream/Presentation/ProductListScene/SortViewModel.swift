//
//  SortViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/09.
//

import Foundation

protocol SortViewModelInput { }
protocol SortViewModelOutput {
    var numberOfRows: Int { get }
    var filters: [SortInfo] { get }
    var heightInfo: Double { get }
}
 
protocol SortViewModel: SortViewModelInput, SortViewModelOutput { }

final class DefaultSortViewModel: SortViewModel {
    private let defaultCellHeight: Double = 70.0
    var filters: [SortInfo] = SortInfo.allCases
    
    var heightInfo: Double {
        return defaultCellHeight * Double(filters.count)
    }
    
    var numberOfRows: Int {
        return filters.count
    }
}

enum SortInfo: String, CaseIterable {
    case totalSale = "total_sale"
    case premiumPrice = "premium_price"
    case lowestAsk = "lowest_ask"
    case highestBid = "highest_bid"
    case releasedDate = "released_date"
    
    var description: String {
        rawValue
    }

    var translatedString: String {
        switch self {
        case .totalSale:    return "인기순"
        case .premiumPrice: return "프리미엄순"
        case .lowestAsk:    return "즉시 구매가순"
        case .highestBid:   return "즉시 판매가순"
        case .releasedDate: return "발매일순"
        }
    }
}
