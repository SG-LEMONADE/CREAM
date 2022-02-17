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
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray3
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReleaseInfoCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(templateLabel, valueLabel)
    }
    
    func setupConstraints() {
        templateLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.leading.equalTo(self.snp.leading).offset(5)
            $0.trailing.equalTo(self.snp.trailing).offset(-5)
            $0.bottom.equalTo(valueLabel.snp.top).offset(-5)
        }
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(5)
            $0.trailing.equalTo(self.snp.trailing).offset(-5)
            $0.bottom.lessThanOrEqualTo(self.snp.bottom).offset(-5)
        }
        templateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func viewConfigure() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 10
    }
}

// MARK: Cell Configure Info
extension ReleaseInfoCell {
    func configure(with info: (String, String)) {
        self.templateLabel.text = info.0
        self.valueLabel.text = info.1
    }
}
