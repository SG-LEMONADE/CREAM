//
//  ItemInfoCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import UIKit
import SnapKit

protocol ItemInfoCellDelegate: AnyObject {
    func didTapSizeButton()
}

class ItemInfoCell: UICollectionViewCell {
    static let reuseIdentifier = "\(ItemInfoCell.self)"
    
    weak var delegate: ItemInfoCellDelegate?
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var translateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var detailStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [detailLabel, translateLabel])
        sv.alignment = .leading
        sv.spacing = 5
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var infoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [brandLabel, detailStackView])
        sv.alignment = .leading
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    private lazy var sizeButton: SizeButton = {
        let button = SizeButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down.circle"), for: .normal)
        button.contentHorizontalAlignment = .leading
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: 5)
        button.addTarget(self, action: #selector(didTabSizeButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var recentDescLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "최근 거래가(안내메시지)"
        label.textAlignment = .left
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var recentPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "최근 거래가(값)"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [recentDescLabel,
                                                recentPriceLabel])
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.text = "가격 변화 정도"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
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
    
    override func prepareForReuse() {
        
    }
}

extension ItemInfoCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(infoStackView,
                         sizeButton,
                         priceStackView,
                         priceChangeLabel)
    }
    
    func setupConstraints() {
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(sizeButton.snp.top).offset(-10)
        }
        
        sizeButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
        }
        
        priceStackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(priceChangeLabel.snp.top).offset(-5)
        }
        
        priceChangeLabel.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
            $0.leading.equalTo(self.snp.leading).offset(10)
        }
    }
}

// MARK: User Event
extension ItemInfoCell {
    @objc func didTabSizeButton() {
        self.delegate?.didTapSizeButton()
    }
}

// MARK: Configure Cell Info
extension ItemInfoCell {
    func configure(_ product: ProductDetail, size: String) {
        recentDescLabel.text = "최근 거래가"
        brandLabel.text = product.brandName
        detailLabel.text = product.originalName
        translateLabel.text = product.translatedName
        if let price = product.lastSalePrice {
            recentPriceLabel.text = price.priceFormat+"원"
        } else {
            recentPriceLabel.text = "-"
        }
        if let changeValue = product.changeValue,
           let changePercent = product.changePercentage {
            let result = "\(changeValue.priceFormat)원 \(changePercent.toPercentageFormat)"
            
            if changePercent > 0 {
                priceChangeLabel.text = "▲\(result)"
                priceChangeLabel.textColor = TradeType.buy.color
            } else if changeValue < 0 {
                priceChangeLabel.text = "▼\(result)"
                priceChangeLabel.textColor = TradeType.sell.color
            } else {
                priceChangeLabel.text =  "-\(changePercent.toPercentageFormat)"
                priceChangeLabel.textColor = .black
            }
        } else {
            priceChangeLabel.text = "-"
        }
        
        if size != "" {
            sizeButton.setTitle(size, for: .normal)
        } else {
            sizeButton.setTitle("모든 사이즈", for: .normal)
        }
    }
}

extension Int {
    var priceFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let result = numberFormatter.string(for: self) {
            return result
        }
        return "-"
    }
    
    var priceFormatWithUnit: String {
        return priceFormat != "" ? priceFormat + "원" : priceFormat
    }
}

extension Double {
    var toPercentageFormat: String {
        if self != 0 {
            return "(\(self)%)"
        } else {
            return "(0%)"
        }
    }
}
