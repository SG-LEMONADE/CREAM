//
//  DeadlineCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/17.
//

import UIKit
import SnapKit

class DeadlineCell: UICollectionViewCell {
    static let reuseIdentifier = "\(DeadlineCell.self)"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.black.cgColor
                sizeLabel.font = UIFont.boldSystemFont(ofSize: 18)
            } else {
                layer.borderColor = UIColor.systemGray5.cgColor
                sizeLabel.font = UIFont.systemFont(ofSize: 18)
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
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
}

extension DeadlineCell: ViewConfiguration {
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

extension DeadlineCell {
    func configure(date: Int) {
        self.sizeLabel.text = "\(date)일"
    }
}
