//
//  BindingTextField.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import UIKit

class BindingTextField: UITextField {
    var textChanged: (String) -> Void = { _ in }
    
    private var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .gray
        
        return underlineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        applyViewSettings()
    }
    
    @objc
    func textFieldDidChanged(_ textField: UITextField) {
        textField.text
            .flatMap { textChanged($0) }
    }
}


extension BindingTextField: ViewConfiguration {
    func buildHierarchy() {
        addSubview(underlineView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setUnderlineViewColor(_ color: UIColor = .gray) {
        underlineView.backgroundColor = color
    }
}
