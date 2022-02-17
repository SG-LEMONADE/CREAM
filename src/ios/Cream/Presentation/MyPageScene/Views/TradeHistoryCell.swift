//
//  TradeHistoryCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/11.
//

import UIKit

final class MyTradeCell: UITableViewCell {
    static let reuseIdentifier: String = "\(MyTradeCell.self)"
    
    var buyHistoryAction: (() -> Void)?
    var sellHistoryAction: (() -> Void)?
    
    private lazy var buyTradeHistoryView: TradeHistoryView = {
        let view = TradeHistoryView()
        return view
    }()
    
    private lazy var sellTradeHistoryView: TradeHistoryView = {
        let view = TradeHistoryView()
        return view
    }()
    
    private lazy var tradeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyTradeHistoryView,
                                                       sellTradeHistoryView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserAction() {
        let buyTradeHistoryGesture = UITapGestureRecognizer(target: self, action:     #selector(didTapBuyTradeHistory(sender:)))
        buyTradeHistoryView.tradeHistoryStack.addGestureRecognizer(buyTradeHistoryGesture)
        
        buyTradeHistoryView.seeMoreButton.addTarget(self, action: #selector(didTapBuyTradeHistory(sender:)), for:     .touchUpInside)
        
        let sellTradeHistoryGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSellTradeHistory(sender:)))
        sellTradeHistoryView.tradeHistoryStack.addGestureRecognizer(sellTradeHistoryGesture)
        sellTradeHistoryView.seeMoreButton.addTarget(self, action: #selector(didTapSellTradeHistory(sender:)), for:     .touchUpInside)
    }
    
    @objc
    func didTapBuyTradeHistory(sender: UITapGestureRecognizer) {
        buyHistoryAction?()
    }
    
    @objc
    func didTapSellTradeHistory(sender: UITapGestureRecognizer) {
        sellHistoryAction?()
    }
}

extension MyTradeCell: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubviews(tradeStackView)
    }
    
    func setupConstraints() {
        buyTradeHistoryView.snp.makeConstraints {
            $0.height.equalTo(sellTradeHistoryView.snp.height)
        }
        
        tradeStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func viewConfigure() {
        buyTradeHistoryView.totalHistoryView.countLabel
            .textColor = UIColor(rgb: 0xEF6253)
        sellTradeHistoryView.totalHistoryView.countLabel
            .textColor = UIColor(rgb: 0x41B979)
        selectionStyle = .none
        tradeStackView.isUserInteractionEnabled = true
        buyTradeHistoryView.sectionLabel.text = "구매 내역"
        sellTradeHistoryView.sectionLabel.text = "판매 내역"
        setupUserAction()
    }
}

extension MyTradeCell {
    func configure(ask: TradeList,
                   bid: TradeList) {
        buyTradeHistoryView.totalHistoryView.countLabel.text = "\(ask.counter.totalCnt)"
        buyTradeHistoryView.bidHistoryView.countLabel.text = "\(ask.counter.waitingCnt)"
        buyTradeHistoryView.progressHistoryView.countLabel.text = "\(ask.counter.inProgressCnt)"
        buyTradeHistoryView.completeHistoryView.countLabel.text = "\(ask.counter.finishedCnt)"
        sellTradeHistoryView.totalHistoryView.countLabel.text = "\(bid.counter.totalCnt)"
        sellTradeHistoryView.bidHistoryView.countLabel.text = "\(bid.counter.waitingCnt)"
        sellTradeHistoryView.progressHistoryView.countLabel.text = "\(bid.counter.inProgressCnt)"
        sellTradeHistoryView.completeHistoryView.countLabel.text = "\(bid.counter.finishedCnt)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        buyTradeHistoryView.sectionLabel.text = nil
        sellTradeHistoryView.sectionLabel.text = nil
        buyTradeHistoryView.totalHistoryView.countLabel.text = nil
        buyTradeHistoryView.bidHistoryView.countLabel.text = nil
        buyTradeHistoryView.progressHistoryView.countLabel.text = nil
        buyTradeHistoryView.completeHistoryView.countLabel.text = nil
        sellTradeHistoryView.totalHistoryView.countLabel.text = nil
        sellTradeHistoryView.bidHistoryView.countLabel.text = nil
        sellTradeHistoryView.progressHistoryView.countLabel.text = nil
        sellTradeHistoryView.completeHistoryView.countLabel.text = nil
    }
}

class TradeHistoryComponentView: UIView {
    lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sectionLabel, countLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
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

extension TradeHistoryComponentView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(containerStackView)
    }
    
    func setupConstraints() {
        countLabel.snp.makeConstraints {
            $0.width.equalTo(sectionLabel.snp.width)
        }
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Inner Views
class TradeHistoryView: UIView {
    lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "내역"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .trailing
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("더보기", for: .normal)
        return button
    }()
    
    lazy var headerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sectionLabel,
                                                       seeMoreButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var totalHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "전체"
        return view
    }()
    
    lazy var bidHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "입찰 중"
        return view
    }()
    
    lazy var progressHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "진행 중"
        return view
    }()
    
    lazy var completeHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "종료"
        return view
    }()
    
    lazy var tradeHistoryStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalHistoryView,
                                                       bidHistoryView,
                                                       progressHistoryView,
                                                       completeHistoryView])
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        return stackView
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

extension TradeHistoryView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(headerStack, tradeHistoryStack)
    }
    
    func setupConstraints() {
        sectionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        seeMoreButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        headerStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tradeHistoryStack.snp.top).offset(-10)
            $0.height.equalTo(tradeHistoryStack.snp.height).multipliedBy(0.3)
        }
        tradeHistoryStack.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(tradeHistoryStack.snp.width).multipliedBy(0.2)
        }
    }
}
