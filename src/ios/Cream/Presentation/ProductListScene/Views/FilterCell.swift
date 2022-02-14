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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = UIColor(rgb: 0xEF6253)
            } else {
                titleLabel.textColor = .black
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
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
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}
