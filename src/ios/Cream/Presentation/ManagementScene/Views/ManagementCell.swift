//
//  ManagementCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/20.
//

import UIKit
import SnapKit

class ManagementCell: UITableViewCell, ImageLoadable {
    static let reuseidentifer = "\(ManagementCell.self)"
    
    var session: URLSessionDataTask?
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray3
        return imageView
    }()
    
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = .systemGray3
        return label
    }()
    
    private lazy var productStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [productLabel, sizeLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var deadLineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var productRightStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, deadLineLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ManagementCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(productImageView,
                    productStackView,
                    productRightStackView)
    }
    
    func setupConstraints() {
        productImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(productImageView.snp.width)
        }
        
        productStackView.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalTo(productRightStackView.snp.leading).offset(-10)
        }
        
        productRightStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    func viewConfigure() {
        selectionStyle = .none
    }
}

extension ManagementCell {
    func configure(trade: Trade) {
        productLabel.text = trade.name
        sizeLabel.text = trade.size
        priceLabel.text = "130,000"
        deadLineLabel.text = trade.validationDate
        
        guard let urlString = trade.imageUrl.first,
              let url = URL(string: urlString)
        else {
            productImageView.image = UIImage(systemName: "questionmark.app.dashed")
            return
        }
        
        trade.backgroundColor.hexToInt.flatMap {
            productImageView.backgroundColor = UIColor(rgb: $0)
        }
        if let image = imageCache.image(forKey: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.productImageView.image = image
            }
        } else {
            session = loadImage(url: url) { (image) in
                image.flatMap { imageCache.add($0, forKey: urlString) }
                DispatchQueue.main.async { [weak self] in
                    self?.productImageView.image = image
                }
            }
        }
    }
    
}
