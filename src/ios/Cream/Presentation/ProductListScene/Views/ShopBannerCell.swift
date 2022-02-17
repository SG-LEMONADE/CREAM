//
//  ShopBannerCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit

final class ShopBannerCell: UICollectionViewCell, ImageLoadable {
    
    var session: URLSessionDataTask?
    
    static let reuseIdentifier = "\(ShopBannerCell.self)"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        self.imageView.image = nil
        self.imageView.backgroundColor = nil
        self.session = nil
    }
}
// MARK: - ViewConfiguration
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

// MARK: - Configure Cell
extension ShopBannerCell {
    func configure(_ image: String) {
        guard let url = URL(string: image) else { return }
        session = loadImage(url: url) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    func configureAds(_ image: String, contentMode: UIView.ContentMode = UIView.ContentMode.scaleAspectFill) {
        imageView.contentMode = contentMode
        let image = UIImage(named: image)
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
