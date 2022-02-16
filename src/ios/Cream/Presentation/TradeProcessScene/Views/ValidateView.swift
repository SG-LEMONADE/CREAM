//
//  ValidateView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import UIKit

final class ValidateView: UIView {
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "입찰 마감기한"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var dateValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var arrayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.down.circle")
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .systemGray4
        return underlineView
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

extension ValidateView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(descriptionLabel,
                    dateValueLabel,
                    arrayImageView,
                    underlineView)
    }
    
    func setupConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
            $0.bottom.equalTo(dateValueLabel.snp.top).offset(-10)
        }
        
        dateValueLabel.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        arrayImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(dateValueLabel.snp.bottom).offset(-5)
            $0.top.equalTo(dateValueLabel.snp.top)
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(4)
        }
    }
}
