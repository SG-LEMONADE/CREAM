//
//  ShopBannerCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit

final class ShopBannerCell: UICollectionViewCell {
    static let reuseIdentifier = "\(ShopBannerCell.self)"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
        
    func configure(_ image: String) {
        self.imageView.image = UIImage(named: image)
    }
}

extension ShopBannerCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
