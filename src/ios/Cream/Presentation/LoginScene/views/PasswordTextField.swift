//
//  PasswordTextField.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/14.
//

import UIKit

class PasswordTextField: UITextField {
    var textChanged: (String) -> Void = { _ in }
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isSecureTextEntry {
                eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            } else {
                eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }
    }
    private var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .gray
        
        return underlineView
    }()
    
    private var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .systemGray
        return button
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
        eyeButton.addTarget(self, action: #selector(didTapEyeButton), for: .touchUpInside)
    }
    
    @objc
    func textFieldDidChanged(_ textField: UITextField) {
        textField.text
            .flatMap { textChanged($0) }
    }
    
    @objc
    func didTapEyeButton() {
        isSecureTextEntry.toggle()
    }
}

extension PasswordTextField: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(eyeButton,
                    underlineView)
    }
    
    func setupConstraints() {
        eyeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(1)
        }
    }
    func viewConfigure() {
        isSecureTextEntry = true
        configureUserEvent()
    }
    
    func setUnderlineViewColor(_ color: UIColor = .gray) {
        underlineView.backgroundColor = color
    }
}
