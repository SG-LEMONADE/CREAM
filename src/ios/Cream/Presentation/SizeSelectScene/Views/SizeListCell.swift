//
//  SizeListCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import UIKit
import SnapKit

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
        label.textAlignment = .center
        return label
    }()
}

extension SizeListCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(sizeLabel)
    }
    
    func setupConstraints() {
        sizeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1
    }
}

extension SizeListCell {
    func configure(size: String) {
        self.sizeLabel.text = size
    }
}
