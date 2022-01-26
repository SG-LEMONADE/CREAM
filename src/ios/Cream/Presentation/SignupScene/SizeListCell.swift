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


class SizeListCell: UICollectionViewCell {
    static let reuseIdentifier = "\(SizeListCell.self)"
    
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
        label.layer.cornerRadius = 16
        label.textAlignment = .center
        label.layer.borderColor = UIColor.systemGray5.cgColor
        label.layer.borderWidth = 1
        return label
    }()
}

extension SizeListCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(sizeLabel)
    }
    
    func setupConstraints() {
        sizeLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}

extension SizeListCell {
    func configure(with viewModel: SizeListCellViewModel) {
        self.sizeLabel.text = viewModel.sizeText
    }
}
