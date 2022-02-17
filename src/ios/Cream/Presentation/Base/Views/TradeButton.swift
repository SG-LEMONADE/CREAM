//
//  TradeButton.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import UIKit
import SnapKit

final class TradeContainerView: UIView {
    
    lazy var buyButton: TradeButton = {
        let button = TradeButton(tradeType: .buy)
        return button
    }()
    
    lazy var sellButton: TradeButton = {
        let button = TradeButton(tradeType: .sell)
        return button
    }()
    
    lazy var wishButton: WishButton = {
        let button = WishButton(frame: .zero)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

extension TradeContainerView: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(buyButton, sellButton, wishButton)
    }
    
    func setupConstraints() {
        wishButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
            $0.trailing.equalTo(self.buyButton.snp.leading).offset(-20)
            $0.width.equalTo(self.buyButton.snp.width).multipliedBy(0.5)
        }
        
        buyButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.trailing.equalTo(self.sellButton.snp.leading).offset(-10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
            $0.width.equalTo(self.sellButton.snp.width).multipliedBy(1)
        }
        
        sellButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        wishButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

enum TradeType: String, CustomStringConvertible {
    case buy, sell
    
    var color: UIColor {
        if self == .buy {
            return UIColor(rgb: 0xEF6253) 
        } else {
            return UIColor(rgb: 0x41B979)
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
    
    var requestString: String {
        switch self {
        case .buy:
            return "ASK"
        case .sell:
            return "BID"
        }
    }
    

    
    var bottomDescription: String {
        switch self {
        case .buy:
            return "총 결제 금액"
        case .sell:
            return "정산 금액"
        }
    }
    
    var navigationTitle: String {
        return self.description+"하기"
    }
    
    var labelText: String {
        return "즉시 \(self.description)가"
    }
}

final class TradeButton: UIButton {
    private var tradeType: TradeType
    private var price: Int?
    
    init(tradeType: TradeType, price: Int? = nil) {
        self.tradeType = tradeType
        self.price = price
        super.init(frame: .zero)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = tradeType.description
        label.textColor = .white
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        if let price = price {
            label.text = "\(price)원"
        } else {
            label.text = "\(tradeType.description) 입찰"
        }
        
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xfce1e0)
        label.text = tradeType.labelText
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, detailLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
}

extension TradeButton: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(typeLabel, infoStackView)
    }
    
    func setupConstraints() {
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.infoStackView.snp.leading).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.top)
            $0.bottom.equalTo(typeLabel.snp.bottom)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
        }
    }
    
    func viewConfigure() {
        backgroundColor = tradeType.color
        layer.cornerRadius = 10
    }
}

extension TradeButton {
    func setPrice(_ price: Int?) {
        if let price = price {
            self.priceLabel.text = "\(price.priceFormat)원"
        } else {
            self.priceLabel.text = "\(tradeType.labelText)"
        }
    }
}
