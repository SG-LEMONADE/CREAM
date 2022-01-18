//
//  HomeViewCategoryHeaderView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit

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
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemGray3
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView.init(frame: .zero)
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.addArrangedSubviews(titleLabel, detailLabel)
        return stackView
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

extension HomeViewCategoryHeaderView {
    func configure(_ headerInfo: String) {
        self.titleLabel.text = "header \(headerInfo)"
        self.detailLabel.text = "detail \(headerInfo)"
    }
}

// MARK: - ViewConfiguration
extension HomeViewCategoryHeaderView: ViewConfiguration {
    func setupConstraints() {
        labelStackView.frame = bounds
    }
    
    func buildHierarchy() {
        addSubviews(labelStackView)
    }
}
