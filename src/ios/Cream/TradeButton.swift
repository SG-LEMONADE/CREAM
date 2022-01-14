//
//  TradeButton.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//


import UIKit
import SnapKit



final class TradeButton: UIButton {
    
    enum TradeType: String, CustomStringConvertible {
        case buy, sell
        
        var color: UIColor {
            if self == .buy {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
        
        var description: String {
            switch self {
            case .buy:
                return "구매"
            case .sell:
                return "판매"
            }
        }
    }
    
    private var tradeType: TradeType
    private var price: Int?
    
    init(tradeType: TradeType, price: Int?) {
        super.init(frame: .zero)
        self.tradeType = tradeType
        self.price = price
//        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        applyViewSettings()
    }
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
