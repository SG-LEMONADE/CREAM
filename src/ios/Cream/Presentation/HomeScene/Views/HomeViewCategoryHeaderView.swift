//
//  HomeViewCategoryHeaderView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit
import SnapKit
import SwiftUI

class HomeViewCategoryHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "\(HomeViewCategoryHeaderView.self)"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemGray3
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView.init(frame: .zero)
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.addArrangedSubviews(titleLabel,
                                      detailLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        detailLabel.text = nil
        titleLabel.textColor = .black
        detailLabel.textColor = .systemGray3
    }
}

extension HomeViewCategoryHeaderView {
    func configure(headerInfo: String, detailInfo: String) {
        titleLabel.text = headerInfo
        detailLabel.text = detailInfo
    }
    
    func configure(brandInfo: String) {
        titleLabel.text = nil
        detailLabel.text = "\(brandInfo)의 다른 상품"
        detailLabel.textColor = .black
    }
}

// MARK: - ViewConfiguration
extension HomeViewCategoryHeaderView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(labelStackView)
    }
    
    func setupConstraints() {
        labelStackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(self.snp.top).inset(25)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}
