//
//  SelectViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import Foundation

enum Layout: Double {
    case list = 1
    case double = 2
    case third = 3
    
    var description: Double {
        rawValue
    }
}

enum SelectionType {
    case wish(size: String = "", isSelected: Bool = false)
    case size(size: String = "")
    case sizePrice(size: String = "", price: Int? = nil)
    case sort(sequence: String = "")
    case deadline(date: Int = 0)
    
    var navigationTitle: String {
        switch self {
        case .wish:
            return "관심 상품 추가"
        case .size:
            return "사이즈 선택"
        case .sizePrice:
            return "사이즈"
        case .sort:
            return "정렬 순서"
        
        case .deadline:
            return "입찰 마감기한"
        }
    }
}

protocol SelectViewModelInput { }
protocol SelectViewModelOutput {
    var numberOfItems: Int { get }
    var numberOfColumns: Double { get }
    var heightInfo: Double { get }

    var items: [SelectionType] { get }
    var type: SelectionType { get }
}

protocol SelectViewModelInterface: SelectViewModelInput, SelectViewModelOutput { }

final class SelectViewModel: SelectViewModelInterface {
    private let headerHeight: Double = 120.0
    private let defaultCellHeight: Double = 60.0
    
    var type: SelectionType
    var items: [SelectionType]
    var numberOfItems: Int {
        return items.count
    }
    
    var numberOfColumns: Double {
        if case .sort = type {
            return Layout.list.description
        }
        if case .wish = type {
            return Layout.third.description
        }
        if case .deadline = type {
            return Layout.third.description
        }
        
        if items.count < 6 {
            return Layout.list.description
        } else if items.count < 12 {
            return Layout.double.description
        } else {
            return Layout.third.description
        }
    }
    
    var heightInfo: Double {
        var rows: Double = 0
        switch numberOfColumns {
        case Layout.list.description:
            rows = Double(items.count)
        case Layout.double.description:
            rows = ceil(Double(items.count / 2) + 1)
        case Layout.third.description:
            rows = ceil(Double(items.count / 3) + 1)
        default:
            break
        }

        return headerHeight + defaultCellHeight * rows
    }
    
    init(type: SelectionType, items: [SelectionType]) {
        self.type = type
        self.items = items
    }
}

