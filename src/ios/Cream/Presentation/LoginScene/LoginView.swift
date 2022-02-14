//
//  LoginView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit

final class LoginView: UIView {
    enum ViewMessage: String, CustomStringConvertible {
        case emailLabel = "이메일 주소"
        case emailPlaceholder = "예) cream@cream.co.kr"
        case passwordLabel = "비밀번호"
        case passwordPlaceholder = ""
        case emailInvalid = "올바른 이메일을 입력해주세요."
        case passwordInvalid = "영문, 숫자, 특수문자를 조합해서 입력해주세요 .(8-16자)"
        
        var description: String {
            self.rawValue
        }
    }
    
    lazy var cancelButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: nil, action: nil)
        return barButton
    }()
    
    lazy var loginImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cream_logo_detail"))
        return imageView
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = ViewMessage.emailLabel.description
        label.font = label.font.withSize(12)
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = ViewMessage.passwordLabel.description
        label.font = label.font.withSize(12)
        return label
    }()
    
    lazy var emailTextField: BindingTextField = {
        let emailField = BindingTextField(frame: .zero)
        emailField.placeholder = ViewMessage.emailPlaceholder.description
        emailField.font?.withSize(15)
        
        return emailField
    }()
    
    lazy var passwordTextField: PasswordTextField = {
        let passwordField = PasswordTextField()
        passwordField.placeholder = ViewMessage.passwordPlaceholder.description
        passwordField.font?.withSize(15)
        
        return passwordField
    }()
    
    lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.font = label.font.withSize(10)
        label.text = ViewMessage.emailInvalid.description
        return label
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.font = label.font.withSize(10)
        label.text = ViewMessage.passwordInvalid.description
        
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 10
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        button.backgroundColor = .systemGray5
        
        return button
    }()
    
    lazy var joinButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("이메일 가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 11)
        
        return button
    }()
    
    lazy var findIDButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("이메일 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 11)
        
        return button
    }()
    
    lazy var findPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 11)
        
        return button
    }()
    
    lazy var userStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        indicator.hidesWhenStopped = true
        return indicator
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

// MARK: ViewConfiguration
extension LoginView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(loginImageView,
                    emailLabel,
                    emailTextField,
                    emailErrorLabel,
                    passwordLabel,
                    passwordTextField,
                    passwordErrorLabel,
                    loginButton,
                    userStackView,
                    indicatorView)
        
        userStackView.addArrangedSubviews(joinButton,
                                          findIDButton,
                                          findPasswordButton)
        userStackView.addSeparators(at: [1,3], color: .systemGray4)
    }
    
    func setupConstraints() {
        loginImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(120)
            $0.leading.equalTo(self).offset(40)
            $0.trailing.equalTo(self).offset(-40)
            $0.height.equalTo(loginImageView.snp.width).multipliedBy(0.4)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(loginImageView.snp.bottom).offset(20)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(40)
        }
        
        emailErrorLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(10)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailErrorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(40)
        }
        
        passwordErrorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(0)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(10)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordErrorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.width.equalTo(loginButton.snp.height).multipliedBy(7 / 1)
        }
        
        userStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.width.equalTo(loginButton.snp.height).multipliedBy(7 / 1)
            $0.height.equalTo(loginButton.snp.height).multipliedBy(0.5)
        }
        
        joinButton.snp.makeConstraints {
            $0.width.equalTo(findIDButton.snp.width)
            $0.width.equalTo(findPasswordButton.snp.width)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
    }
    
    func viewConfigure() {
        self.backgroundColor = .white
    }
}
