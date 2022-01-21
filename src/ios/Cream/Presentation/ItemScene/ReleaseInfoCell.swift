//
//  ReleaseInfoCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import UIKit
import SnapKit

class ReleaseInfoCell: UICollectionViewCell {
    static let reuseIdentifier = "\(ReleaseInfoCell.self)"
    
    private lazy var templateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

extension ReleaseInfoCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(templateLabel, valueLabel)
    }
    
    func setupConstraints() {
        self.templateLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.leading.equalTo(self.snp.leading).offset(5)
            $0.trailing.equalTo(self.snp.leading).offset(-5)
            $0.bottom.equalTo(valueLabel.snp.top).offset(-5)
        }
        self.valueLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(5)
            $0.trailing.equalTo(self.snp.leading).offset(-5)
            $0.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
}

// MARK: Cell Configure Info
extension ReleaseInfoCell {
    func configure(_ data: String) {
        templateLabel.text = "MODEL NUMBER"
        valueLabel.text = "SERIAL \(Int.random(in: 0...100))"
        
        myLogPrint("ModelInfoCell")
    }
}
