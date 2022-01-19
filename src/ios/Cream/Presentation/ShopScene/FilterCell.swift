//
//  FilterCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

import UIKit
import SnapKit

final class FilterCell: UICollectionViewCell {
    static let reuseIdentifer = "\(FilterCell.self)"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.showsExpansionTextWhenTruncated = true
        label.frame.size = label.intrinsicContentSize
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemGray6
        layer.cornerRadius = frame.height / 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    func configure(_ data: String) {
        self.titleLabel.text = data
    }
}

extension FilterCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
}
