//
//  BindingTextField.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import UIKit
import SnapKit

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
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    
    private func configureUserEvent() {
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
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
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(1)
        }
    }
    func viewConfigure() {
        configureUserEvent()
    }
    
    func setUnderlineViewColor(_ color: UIColor = .gray) {
        underlineView.backgroundColor = color
    }
}
