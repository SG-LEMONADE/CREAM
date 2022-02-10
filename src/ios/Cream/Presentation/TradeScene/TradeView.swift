//
//  TradeView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/01.
//

import UIKit

class ProductInfoView: UIView {
    lazy var modelImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    lazy var itemNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    lazy var itemTranslatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray2
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemNumberLabel, itemTitleLabel, itemTranslatedLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [modelImageView, labelStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.backgroundColor = .white
        return stackView
    }()
}

extension ProductInfoView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(containerStackView)
    }
    
    func setupConstraints() {
        modelImageView.snp.makeConstraints {
            $0.width.equalTo(self.snp.width).multipliedBy(0.25)
            $0.width.equalTo(self.modelImageView.snp.height)
            $0.leading.equalTo(containerStackView.snp.leading).inset(10)
            $0.height.greaterThanOrEqualTo(labelStackView.snp.height)
            $0.trailing.equalTo(labelStackView.snp.leading).offset(-10)
            $0.bottom.equalTo(containerStackView.snp.bottom).inset(10)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.top).inset(10)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func viewConfigure() {
        self.backgroundColor = .white
    }
}

class TradeView: UIView {
    enum Constraint {
        private enum Inset {
            static let left: CGFloat = 2
            static let right: CGFloat = 2
            static let top: CGFloat = 2
            static let down: CGFloat = 2
        }
        static let itemSpace: CGFloat = 2
        static let lineSpace: CGFloat = 2
        
        static let GridWidthSpacing: CGFloat = itemSpace + Inset.left + Inset.right
        static let GridHeightSpacing: CGFloat = lineSpace + Inset.top + Inset.down
    }
    
    lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    lazy var topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray2
        label.text = "(가격 단위: 원)"
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()

    lazy var navigationTitleView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        stackView.axis = .vertical
        stackView.addArrangedSubviews(topTitleLabel, topDescriptionLabel)
        
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var modelImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor.systemGray6
        return imageView
    }()
    
    lazy var itemNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    lazy var itemTranslatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray2
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemNumberLabel, itemTitleLabel, itemTranslatedLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [modelImageView, labelStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var sizeListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = Constraint.itemSpace
        layout.minimumLineSpacing = Constraint.lineSpace
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    lazy var tradeButton: SizePriceButton = {
        let button = SizePriceButton(frame: .zero)
        button.backgroundColor = .black
        button.contentHorizontalAlignment = .center
        button.isHidden = true
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
}

extension TradeView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(containerStackView, sizeListView, tradeButton)
    }
    
    func setupConstraints() {
        modelImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.width.equalTo(self.modelImageView.snp.height)
            $0.leading.equalTo(containerStackView.snp.leading).inset(10)
            $0.height.greaterThanOrEqualTo(labelStackView.snp.height)
            $0.trailing.equalTo(labelStackView.snp.leading).offset(-10)
            $0.bottom.equalTo(containerStackView.snp.bottom).inset(10)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.top).inset(10)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(sizeListView.snp.top)
        }
        
        sizeListView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).inset(10)
            $0.trailing.equalTo(self.snp.trailing).inset(10)
            $0.bottom.equalTo(tradeButton.snp.top)
        }
        
        tradeButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalTo(self.snp.leading).inset(10)
            $0.trailing.equalTo(self.snp.trailing).inset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func viewConfigure() {
        self.backgroundColor = .white
    }
}
