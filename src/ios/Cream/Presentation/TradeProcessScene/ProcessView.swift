//
//  ProcessView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/04.
//

import UIKit
import SnapKit

class TradeBottomBar: UIView {
    lazy var totalLabel: TradePriceView = {
        let tradePriceView = TradePriceView()
        tradePriceView.tradeTypeLabel.text = "총 결제금액"
        tradePriceView.tradeTypeLabel.textColor = .black
        tradePriceView.priceLabel.text = "-"
        tradePriceView.priceLabel.textColor = .black
        return tradePriceView
    }()
    
    lazy var tradeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("즉시 구매", for: .normal)
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

extension TradeBottomBar: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(totalLabel, tradeButton)
    }
    
    func setupConstraints() {
        totalLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.greaterThanOrEqualTo(tradeButton.snp.leading)
        }
        
        tradeButton.snp.makeConstraints {
            $0.top.bottom.equalTo(totalLabel)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
    }
}

class ProcessView: UIView {
    lazy var productInfoView: ProductInfoView = {
        let view = ProductInfoView()
        return view
    }()
    
    lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
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
        segment.selectedSegmentTintColor = UIColor(rgb: 0xEF6253)
        segment.backgroundColor = .systemGray6
        segment.defaultConfiguration()
        segment.selectedConfiguration()
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 50
        segment.layer.borderColor = UIColor.white.cgColor
        segment.layer.borderWidth = 1.0
        segment.layer.masksToBounds = true
        return segment
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "즉시 구매가"
        label.sizeToFit()
        return label
    }()
    
    lazy var priceTextField: PriceInputView = {
        let inputView = PriceInputView()
        inputView.textField.textAlignment = .right
        inputView.textField.keyboardType = .decimalPad
        inputView.textField.font = UIFont.systemFont(ofSize: 20)
        inputView.textField.addButtonOnKeyboard(name: "완료")
        return inputView
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    lazy var secondDivisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
        let stack = UIStackView(arrangedSubviews: [inspectionLabel, deliveryLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var infoValueStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [inspectionValueLabel, deliveryValueLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoDescriptionStack, infoValueStack])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var tradeBottomBar: TradeBottomBar = {
        let view = TradeBottomBar()
        return view
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
                    divisionView,
                    requestStackView,
                    segmentControl,
                    descriptionLabel,
                    priceTextField,
                    borderView,
                    secondDivisionView,
                    infoStack,
                    tradeBottomBar)
    }
    
    func setupConstraints() {
        secondDivisionView.setContentHuggingPriority(.defaultLow,
                                                     for: .vertical)
        secondDivisionView.setContentCompressionResistancePriority(.defaultLow,
                                                                   for: .vertical)
        
        productInfoView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(divisionView.snp.top)
        }
        
        divisionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
            $0.bottom.equalTo(requestStackView.snp.top)
        }
        
        requestStackView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.06)
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
            $0.bottom.equalTo(infoStack.snp.top).offset(-10)
        }
        
        infoStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(borderView.snp.top)
            $0.height.equalTo(60)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
            $0.bottom.equalTo(secondDivisionView.snp.top)
        }
        
        secondDivisionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tradeBottomBar.snp.top)
        }
        
        tradeBottomBar.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func viewConfigure() {
        tradeBottomBar.totalLabel.priceLabel.textAlignment = .left
        tradeBottomBar.totalLabel.priceLabel.textAlignment = .left
        tradeBottomBar.totalLabel.tradeTypeLabel.textAlignment = .left
        backgroundColor = .white
    }
}
