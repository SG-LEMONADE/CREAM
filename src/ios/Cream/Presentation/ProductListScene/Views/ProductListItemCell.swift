//
//  ProductListItemCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/06.
//

import UIKit
import SnapKit

final class ProductListItemCell: UICollectionViewCell {
    static let reuseIdentifier = "\(HomeProductCell.self)"
    
    var sessionTask: URLSessionDataTask?
    
    private lazy var itemView: BaseItemView = {
        let itemView = BaseItemView()
        return itemView
    }()
    
    private lazy var wishButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray4
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.setTitleColor(.systemGray4, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .black)
        button.contentHorizontalAlignment = .leading
        return button
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
        
        self.itemView.productImageView.image = nil
        self.itemView.titleLabel.text = nil
        self.itemView.tradeLabel.text = nil
        self.itemView.detailLabel.text = nil
        self.wishButton.setTitle(nil, for: .normal)
        self.itemView.priceLabel.text = nil
        self.itemView.priceExpressionLabel.text = nil
    }
}

// MARK: - ViewConfiguration
extension ProductListItemCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(itemView,
                         wishButton)
    }
    
    func setupConstraints() {
        itemView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(wishButton.snp.top).offset(-10)
        }
        wishButton.snp.makeConstraints {
            $0.leading.equalTo(itemView.snp.leading).offset(10)
            $0.width.equalTo(itemView.snp.width).multipliedBy(0.3)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}

// MARK: - Cell Configure
extension ProductListItemCell {
    func configure(_ viewModel: Product) {
        self.itemView.tradeLabel.text = viewModel.totalSaleText
        self.itemView.titleLabel.text = viewModel.brandName
        self.itemView.detailLabel.text = viewModel.originalName
        self.wishButton.setTitle(viewModel.wishText, for: .normal)
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
}

extension ProductListItemCell {
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
