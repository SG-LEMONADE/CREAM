//
//  HomeViewItemCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/17.
//

import UIKit
import SnapKit

class HomeViewItemCell: UICollectionViewCell {
    static let reuseIdentifier = "\(HomeViewItemCell.self)"
    
    var sessionTask: URLSessionDataTask?
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var detailLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray4
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var priceLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var priceExpressionLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray4
        return label
    }()
    
    private lazy var wishButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.setTitle("1,234", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .black)
        button.titleLabel?.textColor = .systemGray4
        
        return button
    }()
    
    private lazy var socialButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .left
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.setTitle("4,321", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .black)
        button.titleLabel?.textColor = .systemGray4
        button.isHidden = true
        return button
    }()
    
    private lazy var productStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       detailLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel,
                                                       priceExpressionLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var wishStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wishButton,
                                                       socialButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    override func prepareForReuse() {
        sessionTask?.cancel()
        
    }
}

extension HomeViewItemCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(productImageView,
                         containerStackView,
                         wishButton)
    }
    
    func setupConstraints() {
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
            $0.bottom.equalTo(wishButton.snp.top).offset(-10)
        }
        wishButton.snp.makeConstraints {
            $0.leading.equalTo(containerStackView.snp.leading)
            $0.width.equalTo(containerStackView.snp.width).multipliedBy(0.3)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}

extension HomeViewItemCell {
    func configure(_ viewModel: Product) {
        self.titleLabel.text = viewModel.brandName
        self.detailLabel.text = viewModel.originalName
        if let price = viewModel.premiumPrice {
            self.priceLabel.text = "\(price.priceFormat)원"
        } else {
            self.priceLabel.text = "-"
        }
        self.priceExpressionLabel.text = "즉시 구매가"
        self.productImageView.backgroundColor = .init(rgb: viewModel.backgroundColor.hexToInt ?? 0)
        guard let urlString = viewModel.imageUrls.first,
              let url = URL(string: urlString)
        else { return }
        
        sessionTask = loadImage(url: url) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.productImageView.image = image
            }
        }
    }
    
    func configureTest() {
        self.productImageView.image = UIImage(systemName: "bookmark")?
            .withAlignmentRectInsets(UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10))
        self.productImageView.sizeToFit()
        self.titleLabel.text = "Nike"
        self.detailLabel.text = "Nike Big Swoosh Full Zip \nJacket Black Sail"
        self.priceLabel.text = "269,000원"
    }
}


extension HomeViewItemCell {
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
