//
//  PriceTextField.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import UIKit

class PriceInputView: UIView {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "희망가 입력"
        textField.font = UIFont(name:"HelveticaNeue-Bold", size: 30)
        return textField
    }()
    
    lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .gray
        
        return underlineView
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

extension PriceInputView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(textField,
                    unitLabel,
                    underlineView)
    }
    
    func setupConstraints() {
        textField.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(unitLabel.snp.leading).offset(-5)
        }
        
        unitLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(1)
        }
    }
}
