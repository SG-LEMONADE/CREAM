//
//  SortCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import UIKit
import SnapKit

class SortCell: UICollectionViewCell {
    static let reuseIdentifier = "\(SortCell.self)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    private lazy var sortLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
}

extension SortCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(sortLabel)
    }
    
    func setupConstraints() {
        sortLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        layer.borderWidth = 0.5
    }
}

extension SortCell {
    func configure(sort: String) {
        self.sortLabel.text = sort
    }
}


