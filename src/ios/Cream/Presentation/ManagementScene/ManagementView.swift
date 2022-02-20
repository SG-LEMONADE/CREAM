//
//  ManagementView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/20.
//

import UIKit
import SnapKit

class ManagementView: UIView {
    lazy var bidHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "입찰 중"
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var progressHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "진행 중"
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var completeHistoryView: TradeHistoryComponentView = {
        let view = TradeHistoryComponentView()
        view.sectionLabel.text = "종료"
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var tradeHistoryStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bidHistoryView,
                                                       progressHistoryView,
                                                       completeHistoryView])
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var bidUnderView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    lazy var progressUnderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    lazy var completeUnderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var underLineStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bidUnderView,
                                                       progressUnderView,
                                                       completeUnderView])
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var tradeTabelView: UITableView = {
        let tb = UITableView()
        return tb
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

extension ManagementView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(tradeHistoryStack,
                    underLineStack,
                    tradeTabelView)
    }
    
    func setupConstraints() {
        tradeHistoryStack.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
            $0.bottom.equalTo(underLineStack.snp.top)
        }
        underLineStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(tradeTabelView.snp.top)
        }
        tradeTabelView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}

