//
//  TradePriceView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/02.
//

import UIKit
import SnapKit

class TradePriceView: UIView {
    lazy var tradeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.text = "-"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TradePriceView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(tradeTypeLabel, priceLabel)
    }
    
    func setupConstraints() {
        tradeTypeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(priceLabel.snp.top)
            $0.height.equalTo(priceLabel.snp.height)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
