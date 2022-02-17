//
//  HomeViewItemCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/17.
//

import UIKit
import SnapKit

protocol WishButtonDelegate: AnyObject {
    func didClickWishButton(for indexPath: IndexPath)
}

final class HomeProductCell: UICollectionViewCell {
    static let reuseIdentifier = "\(HomeProductCell.self)"
    
    var indexPath: IndexPath = .init(index: .zero)
    var sessionTask: URLSessionDataTask?
    weak var delegate: WishButtonDelegate?
    
    private lazy var itemView: BaseItemView = {
        let itemView = BaseItemView()
        return itemView
    }()
    
    private lazy var wishButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didSelectWishButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var wishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmark")
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
        sessionTask?.cancel()
        
        itemView.productImageView.image = nil
        itemView.titleLabel.text = nil
        itemView.tradeLabel.text = nil
        itemView.detailLabel.text = nil
        wishButton.setTitle(nil, for: .normal)
        itemView.priceLabel.text = nil
        itemView.priceExpressionLabel.text = nil
    }
}

extension HomeProductCell: ViewConfiguration {
    func buildHierarchy() {
        wishButton.addSubviews(wishImageView)
        itemView.productImageView.addSubviews(wishButton)
        addSubviews(itemView)
    }
    
    func setupConstraints() {
        itemView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        wishImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wishButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(itemView.snp.width).multipliedBy(0.1)
            $0.width.equalTo(itemView.snp.width).multipliedBy(0.08)
        }
    }
    
    func viewConfigure() {
        itemView.productImageView.isUserInteractionEnabled = true
    }
}

// MARK: Cell Configure
extension HomeProductCell {
    func configure(_ viewModel: Product, isRelatedItem: Bool = false) {
        itemView.tradeLabel.text = viewModel.totalSaleText
        itemView.titleLabel.text = viewModel.brandName
        itemView.detailLabel.text = viewModel.originalName
        itemView.priceExpressionLabel.text = "즉시 구매가"
        if let price = viewModel.lowestAsk {
            itemView.priceLabel.text = "\(price.priceFormat)원"
        } else {
            itemView.priceLabel.text = "-"
        }
        
        
        itemView.productImageView.backgroundColor = .init(rgb: viewModel.backgroundColor.hexToInt ?? 0)
        
        if let wishList = viewModel.wishList,
           !wishList.isEmpty {
            wishImageView.image = UIImage(named: "bookmark.fill")
        } else {
            wishImageView.image = UIImage(named: "bookmark")
        }
        
        if isRelatedItem {
            itemView.tradeLabel.text = nil
            wishButton.isHidden = true
        }
        
        
        
        guard let urlString = viewModel.imageUrls.first,
              let url = URL(string: urlString)
        else {
            itemView.productImageView.image = UIImage(systemName: "questionmark.app.dashed")
            return
        }
        if let image = imageCache.image(forKey: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.itemView.productImageView.image = image
            }
        } else {
            sessionTask = loadImage(url: url) { (image) in
                image.flatMap { imageCache.add($0, forKey: urlString) }
                DispatchQueue.main.async { [weak self] in
                    self?.itemView.productImageView.image = image
                }
            }
        }
    }
    
    @objc func didSelectWishButton() {
        delegate?.didClickWishButton(for: indexPath)
    }
}

extension HomeProductCell {
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data
            else { return }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
        return task
    }
}
