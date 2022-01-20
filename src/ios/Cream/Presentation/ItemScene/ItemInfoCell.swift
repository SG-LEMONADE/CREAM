//
//  ItemInfoCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import UIKit
import SnapKit

class ItemInfoCell: UICollectionViewCell {
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private lazy var translateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private lazy var detailStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [detailLabel, translateLabel])
        sv.alignment = .leading
        sv.spacing = 5
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var infoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [brandLabel, detailStackView])
        sv.alignment = .leading
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    private lazy var sizeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var recentDescLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [recentDescLabel, priceLabel])
        sv.axis = .horizontal
        return sv
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

extension ItemInfoCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(infoStackView, sizeButton, priceStackView)
    }
    
    func setupConstraints() {
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(sizeButton.snp.top).offset(10)
        }
        
        sizeButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
        }
        
        priceStackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}

// MARK: Configure Cell Info
extension ItemInfoCell {
    func configure(_ itemInfo: String) {
        
    }
}
