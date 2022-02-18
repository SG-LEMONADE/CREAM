//
//  FinishView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/18.
//

import UIKit

class FinishView: UIView {
    lazy var modelImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "mock_shoe1")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.systemGray5
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "입찰 완료 텍스트"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "결제는 거래가 성사되는 시점에 \n 등록하신 결제 정보로 자동 처리 됩니다."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "총 결제금액"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "가격,원"
        label.textAlignment = .right
        label.textColor = TradeType.buy.color
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, priceValueLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy var priceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "구매 희망가"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "배송비"
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var inspectionLabel: UILabel = {
        let label = UILabel()
        label.text = "검수비"
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var itemPriceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "10,000원"
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var deliveryValueLabel: UILabel = {
        let label = UILabel()
        label.text = "5,000원"
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    lazy var inspectionValueLabel: UILabel = {
        let label = UILabel()
        label.text = "무료"
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var infoDescriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemPriceLabel,
                                                   inspectionLabel,
                                                   deliveryLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    lazy var infoValueStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemPriceValueLabel,
                                                   inspectionValueLabel,
                                                   deliveryValueLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoDescriptionStack, infoValueStack])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        return stack
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    lazy var stretchView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FinishView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(modelImageView,
                    titleLabel,
                    descriptionLabel,
                    priceContainerView,
                    infoStack,
                    underlineView,
                    stretchView)
        priceContainerView.addSubviews(priceStackView)
    }
    
    func setupConstraints() {
        
        priceStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        modelImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(self.snp.width).multipliedBy(0.6)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-30)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-10)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(priceStackView.snp.top).offset(-30)
        }
        priceContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
            $0.bottom.equalTo(infoStack.snp.top).offset(-20)
        }
        infoStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(underlineView.snp.top).offset(-20)
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(3)
            $0.bottom.equalTo(stretchView.snp.top).offset(-20)
        }
        
        stretchView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stretchView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stretchView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}

