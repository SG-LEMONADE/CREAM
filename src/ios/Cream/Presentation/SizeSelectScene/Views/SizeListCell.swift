//
//  SizeListCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import UIKit
import SnapKit

class SizePriceCell: SizeListCell {
    static let reuseIdentifer = "\(SizePriceCell.self)"
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 16
        label.textAlignment = .center
        label.layer.borderColor = UIColor.systemGray5.cgColor
        label.layer.borderWidth = 1
        return label
    }()
}

enum CellType {
    case sizeOnly
    case sizeWithPrice
}

class SizeListCell: UICollectionViewCell {
    static let reuseIdentifier = "\(SizeListCell.self)"
    
    private var type: CellType = .sizeOnly {
        didSet {
            applyViewSettings()
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
        label.textAlignment = .center
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
}

extension SizeListCell: ViewConfiguration {
    func buildHierarchy() {
        if type == .sizeOnly {
            self.addSubviews(sizeLabel)
        } else {
            self.addSubviews(sizeLabel, priceLabel)
        }
    }
    
    func setupConstraints() {
        if type == .sizeOnly {
            sizeLabel.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        } else {
            sizeLabel.snp.makeConstraints {
                $0.leading.trailing.top.equalToSuperview()
                $0.bottom.equalTo(priceLabel.snp.top)
            }
            priceLabel.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    func viewConfigure() {
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1
    }
}

extension SizeListCell {
    func configure(size: String, price: Int?? = nil) {
        self.sizeLabel.text = size
        if let optionalPrice = price,
           let priceText = optionalPrice {
            self.type = .sizeWithPrice
            self.priceLabel.text = priceText.priceFormat
        }
    }
}
