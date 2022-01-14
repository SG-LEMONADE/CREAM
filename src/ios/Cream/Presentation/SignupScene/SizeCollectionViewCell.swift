//
//  SizeCollectionViewCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import UIKit
import SnapKit

class SizeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "\(SizeCollectionViewCell.self)"
    
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
        return label
    }()
}

extension SizeCollectionViewCell: ViewConfiguration {
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
