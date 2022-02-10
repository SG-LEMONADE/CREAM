//
//  BaseItemView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/06.
//

import UIKit
import SnapKit

class BaseItemView: UIView {
    lazy var tradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .systemGray3
        return label
    }()
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var detailLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray4
        label.numberOfLines = 2
        return label
    }()
    
    lazy var priceLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var priceExpressionLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray4
        return label
    }()
    
    lazy var productStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       detailLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel,
                                                       priceExpressionLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        
        return stackView
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productStackView,
                                                       priceStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
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
}

extension BaseItemView: ViewConfiguration {
    func buildHierarchy() {
        productImageView.addSubviews(tradeLabel)
        self.addSubviews(productImageView,
                         containerStackView)
    }
    
    func setupConstraints() {
        tradeLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
        }
        
        productImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.snp.top)
            $0.width.height.equalTo(self.snp.width)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(containerStackView.snp.top).offset(-5)
        }
        containerStackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
