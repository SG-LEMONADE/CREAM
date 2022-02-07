//
//  HomeViewItemCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/17.
//

import UIKit
import SnapKit

final class HomeProductCell: UICollectionViewCell {
    static let reuseIdentifier = "\(HomeProductCell.self)"
    
    var sessionTask: URLSessionDataTask?
    
    private lazy var itemView: BaseItemView = {
        let itemView = BaseItemView()
        return itemView
    }()
    
    private lazy var wishButton: UIButton = {
        let button = UIButton()
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    override func prepareForReuse() {
        sessionTask?.cancel()
        
        self.itemView.productImageView.image = nil
        self.itemView.titleLabel.text = nil
        self.itemView.tradeLabel.text = nil
        self.itemView.detailLabel.text = nil
        self.wishButton.setTitle(nil, for: .normal)
        self.itemView.priceLabel.text = nil
        self.itemView.priceExpressionLabel.text = nil
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
    func configure(_ viewModel: Product) {
        self.itemView.tradeLabel.text = viewModel.totalSaleText
        self.itemView.titleLabel.text = viewModel.brandName
        self.itemView.detailLabel.text = viewModel.originalName
        self.itemView.priceLabel.text = viewModel.price
        self.itemView.priceExpressionLabel.text = "즉시 구매가"
        self.itemView.productImageView.backgroundColor = .init(rgb: viewModel.backgroundColor.hexToInt ?? 0)
        guard let urlString = viewModel.imageUrls.first,
              let url = URL(string: urlString)
        else { return }
        
        sessionTask = loadImage(url: url) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.itemView.productImageView.image = image
            }
        }
    }
    
    func configureTest() {
        self.itemView.productImageView.image = UIImage(systemName: "bookmark")?
            .withAlignmentRectInsets(UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10))
        self.itemView.productImageView.sizeToFit()
        self.itemView.titleLabel.text = "Nike"
        self.itemView.detailLabel.text = "Nike Big Swoosh Full Zip \nJacket Black Sail"
        self.itemView.priceLabel.text = "269,000원"
        self.itemView.priceExpressionLabel.text = "즉시 구매가"
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
