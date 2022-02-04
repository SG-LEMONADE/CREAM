//
//  ProcessView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/04.
//

import UIKit

class ProcessView: UIView {
    lazy var productInfoView: ProductInfoView = {
        let productInfoView = ProductInfoView()
        productInfoView.backgroundColor = .white
        return productInfoView
    }()
    
    lazy var buyLabel: TradePriceView = {
        let tradePriceView = TradePriceView()
        tradePriceView.tradeTypeLabel.text = "즉시 구매가"
        tradePriceView.tradeTypeLabel.textColor = .systemGray2
        tradePriceView.priceLabel.text = "-"
        tradePriceView.priceLabel.textColor = .black
        return tradePriceView
    }()
    
    lazy var sellLabel: TradePriceView = {
        let tradePriceView = TradePriceView()
        tradePriceView.tradeTypeLabel.text = "즉시 판매가"
        tradePriceView.tradeTypeLabel.textColor = .systemGray2
        tradePriceView.priceLabel.text = "-"
        tradePriceView.priceLabel.textColor = .black
        return tradePriceView
    }()
    
    lazy var requestStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyLabel, sellLabel])
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["구매 입찰", "즉시 구매"])
        segment.selectedSegmentIndex = 1
        segment.backgroundColor = .white
        segment.tintColor = .black
        segment.selectedSegmentTintColor = .orange
        segment.layer.cornerRadius = segment.frame.height / 2
        return segment
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "즉시 구매가"
        label.sizeToFit()
        return label
    }()
    
    lazy var priceTextField: BindingTextField = {
        let textField = BindingTextField()
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.font = UIFont.systemFont(ofSize: 20)
        
        textField.addButtonOnKeyboard(name: "완료")
        return textField
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tradeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("결제하기", for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 15
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

extension ProcessView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(productInfoView,
                    requestStackView,
                    segmentControl,
                    descriptionLabel,
                    priceTextField,
                    containerView,
                    buttonContainerView)
        buttonContainerView.addSubviews(tradeButton)
    }
    
    func setupConstraints() {
        productInfoView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.width).multipliedBy(0.4)
            $0.bottom.equalTo(requestStackView.snp.top).offset(-20)
        }
        
        requestStackView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.08)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(segmentControl.snp.top).offset(-20)
        }
        
        segmentControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(descriptionLabel.snp.top)
            $0.height.equalTo(segmentControl.snp.width).multipliedBy(0.1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(priceTextField.snp.top)
            $0.height.equalTo(50)
        }
        
        priceTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(44)
            $0.bottom.equalTo(containerView.snp.top)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tradeButton.snp.top)
        }
        
        buttonContainerView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        tradeButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func viewConfigure() {
        self.backgroundColor = .systemGray6
    }
}
