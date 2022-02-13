//
//  SizePriceButton.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/01.
//

import UIKit
import SnapKit

final class SizePriceButton: UIButton {
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
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

extension SizePriceButton: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(sizeLabel,priceLabel)
    }
    
    func setupConstraints() {
        sizeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(priceLabel.snp.top)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(sizeLabel.snp.height)
        }
    }
    
    func viewConfigure() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
}

extension SizePriceButton {
    func configure(size: String, priceText: String?) {
        self.sizeLabel.text = size
        self.priceLabel.text = priceText
        self.backgroundColor = .black
    }
}
