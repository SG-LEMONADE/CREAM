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
        self.tradeType = tradeType
        self.price = price
        super.init(frame: .zero)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        applyViewSettings()
        super.init(coder: coder)
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
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, detailLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
}


extension TradeButton: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(typeLabel, infoStackView)
    }
    
    func setupConstraints() {
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(10)
            $0.leading.equalTo(self.view.snp.leading).offset(10)
            $0.trailing.equalTo(self.infoStackView.snp.leading).offset(10)
            $0.bottom.equalTo(self.view.snp.bottom).offset(-10)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.top)
            $0.bottom.equalTo(typeLabel.snp.bottom)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-10)
        }
    }
}
