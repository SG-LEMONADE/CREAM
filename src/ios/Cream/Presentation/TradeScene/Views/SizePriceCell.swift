//
//  SizePriceCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/15.
//

import UIKit
import SnapKit

class SizePriceCell: UICollectionViewCell {
    static let reuseIdentifier = "\(SizePriceCell.self)"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.black.cgColor
                sizeLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
                priceLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            } else {
                layer.borderColor = UIColor.systemGray5.cgColor
                sizeLabel.font = UIFont.systemFont(ofSize: 13)
                priceLabel.font = UIFont.systemFont(ofSize: 10)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
}

extension SizePriceCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(sizeLabel, priceLabel)
    }
    
    func setupConstraints() {
        sizeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(priceLabel.snp.top)
            $0.height.equalTo(priceLabel.snp.height)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(3)
        }
    }
    
    func viewConfigure() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.borderWidth = 1
        sizeLabel.sizeToFit()
        priceLabel.sizeToFit()
        
    }
    
    override func prepareForReuse() {
        sizeLabel.text = nil
        priceLabel.text = nil
        priceLabel.textColor = .black
    }
}

extension SizePriceCell {
    func configure(size: String, price: Int?, type: TradeType) {
        sizeLabel.text = size
        priceLabel.textColor = type.color
        if let price = price {
            self.priceLabel.text = "\(price.priceFormat)"
        } else {
            self.priceLabel.text = type.description + "입찰"
            priceLabel.textColor = .black
        }
    }
}
