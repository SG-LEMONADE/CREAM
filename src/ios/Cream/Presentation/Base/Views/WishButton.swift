//
//  WishButton.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import UIKit
import SnapKit

final class WishButton: UIButton {
    private lazy var upperImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private lazy var wishCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
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

extension WishButton: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(upperImageView, wishCountLabel)
    }
    
    func setupConstraints() {
        upperImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.centerX.equalTo(self.snp.centerX)
            $0.bottom.equalTo(wishCountLabel.snp.top)
            $0.width.equalTo(upperImageView.snp.height)
            $0.height.equalTo(wishCountLabel.snp.height).multipliedBy(0.7)
        }
        
        wishCountLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}


extension WishButton {
    func configure(_ product: ProductDetail) {
        self.wishCountLabel.text = "\(product.wishCount)"
        if let wishList = product.wishList, wishList.isEmpty == false {
            self.upperImageView.image = UIImage(systemName: "bookmark.fill")
        } else {
            self.upperImageView.image = UIImage(systemName: "bookmark")
        }
        
        
    }
}
