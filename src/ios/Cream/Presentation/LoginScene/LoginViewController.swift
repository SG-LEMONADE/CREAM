//
//  LoginViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private enum ViewMessage: String, CustomStringConvertible {
        case emailLabel = "이메일 주소"
        case emailPlaceholder = "예) kream@kream.co.kr"
        case passwordLabel = "비밀번호"
        case passwordPlaceholder = "password"
        case emailInvalid = "올바른 이메일을 입력해주세요."
        case passwordInvalid = "영문, 숫자, 특수문자를 조합해서 입력해주세요 .(8-16자)"
        
        var description: String {
            self.rawValue
        }
    }
    
    private var viewModel = LoginViewModel()
    
    private lazy var loginImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loginTitle"))
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = ViewMessage.emailLabel.description
        label.font = label.font.withSize(12)
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = ViewMessage.passwordLabel.description
        label.font = label.font.withSize(12)
        return label
    }()
    
    private lazy var emailTextField: BindingTextField = {
        let emailField = BindingTextField(frame: .zero)
        emailField.placeholder = ViewMessage.emailPlaceholder.description
        emailField.font?.withSize(15)
        
        emailField.bind { [weak self] email in
            if self?.viewModel.validate(email: email) == false {
                self?.emailErrorLabel.isHidden = false
                self?.emailLabel.textColor = .red
                self?.emailTextField.setUnderlineViewColor(.red)
            } else {
                self?.emailErrorLabel.isHidden = true
                self?.emailLabel.textColor = .black
                self?.emailTextField.setUnderlineViewColor(.systemGray6)
            }
            self?.viewModel.email.value = email
        }
        return emailField
    }()
    
    private lazy var passwordTextField: BindingTextField = {
        let passwordField = BindingTextField()
        passwordField.placeholder = ViewMessage.passwordPlaceholder.description
        passwordField.font?.withSize(15)
        passwordField.bind { [weak self] password in
            if self?.viewModel.validate(password: password) == false {
                self?.passwordErrorLabel.isHidden = false
                self?.passwordLabel.textColor = .red
                self?.passwordTextField.setUnderlineViewColor(.red)
            } else {
                self?.passwordErrorLabel.isHidden = true
                self?.passwordLabel.textColor = .black
                self?.passwordTextField.setUnderlineViewColor(.systemGray6)
            }
            self?.viewModel.password.value = password
        }
        return passwordField
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.font = label.font.withSize(10)
        label.text = ViewMessage.emailInvalid.description
        return label
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        label.font = label.font.withSize(10)
        label.text = ViewMessage.passwordInvalid.description
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 10
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        button.backgroundColor = .systemGray5
        
        return button
    }()
    
    private lazy var joinButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .yellow
        button.setTitle("이메일 가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 10)
        return button
    }()
    
    private lazy var findIDButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .green
        button.setTitle("이메일 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 10)
        return button
    }()
    
    private lazy var findPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .red
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 10)
        return button
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.email.bind { [weak self] value in
            self?.viewModel.validateLoginAvailable()
        }
        viewModel.password.bind { [weak self] value in
            self?.viewModel.validateLoginAvailable()
        }

        viewModel.isLoginAvailable.bind { [weak self] value in
            if value == true {
                self?.loginButton.isEnabled = true
                self?.loginButton.backgroundColor = .black
            } else {
                self?.loginButton.isEnabled = false
                self?.loginButton.backgroundColor = .systemGray5
            }
        }
    }
}
extension LoginViewController {
    @objc
    private func login() {
        self.viewModel.login
    }
}

// MARK: - ViewConfiguration
extension LoginViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(loginImageView,
                         emailLabel,
                         emailTextField,
                         emailErrorLabel,
                         passwordLabel,
                         passwordTextField,
                         passwordErrorLabel,
                         loginButton,
                         userStackView)
        
        userStackView.addArrangedSubviews(joinButton,
                                          findIDButton,
                                          findPasswordButton)
    }
    
    func setupConstraints() {
        loginImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(150)
            $0.leading.equalTo(self.view).offset(80)
            $0.trailing.equalTo(self.view).offset(-80)
            $0.height.equalTo(loginImageView.snp.width).multipliedBy(0.3)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(loginImageView.snp.bottom).offset(20)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(40)
        }
        
        emailErrorLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(10)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailErrorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(40)
        }
        
        passwordErrorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(0)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(10)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordErrorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.width.equalTo(loginButton.snp.height).multipliedBy(7 / 1)
        }
        
        userStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.width.equalTo(loginButton.snp.height).multipliedBy(7 / 1)
        }
        
        joinButton.snp.makeConstraints {
            $0.width.equalTo(findIDButton.snp.width)
            $0.width.equalTo(findPasswordButton.snp.width)
        }
    }
}
