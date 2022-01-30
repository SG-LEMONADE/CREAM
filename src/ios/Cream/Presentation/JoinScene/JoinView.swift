//
//  JoinView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit
import SnapKit

class JoinView: UIView {
    enum ViewMessage: String, CustomStringConvertible {
        case emailLabel = "이메일 주소 *"
        case emailInvalid = "올바른 이메일을 입력해주세요."
        case passwordLabel = "비밀번호 *"
        case passwordInvalid = "영문, 숫자, 특수문자를 조합해서 입력해주세요 .(8-16자)"
        case sneakersSizeLabel = "스니커즈 사이즈"
        case signupButton = "가입하기"
        
        var description: String {
            self.rawValue
        }
    }
    
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
    
    lazy var sneakersSizeLabel: UILabel = {
        let label = UILabel()
        label.text = ViewMessage.sneakersSizeLabel.description
        label.font = label.font.withSize(12)
        return label
    }()
    
    lazy var emailTextField: BindingTextField = {
        let emailField = BindingTextField(frame: .zero)
        emailField.font?.withSize(15)
        
        return emailField
    }()
    
    lazy var passwordTextField: BindingTextField = {
        let passwordField = BindingTextField()
        passwordField.font?.withSize(15)

        return passwordField
    }()
    
    lazy var sneakersSizeButton: SizeButton = {
        let button = SizeButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("선택하세요", for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down.circle"), for: .normal)
        button.contentHorizontalAlignment = .leading
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: 5)
        
        return button
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
    
    lazy var signupButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 10
        button.setTitle(ViewMessage.signupButton.description, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        button.backgroundColor = .systemGray5
        
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

extension JoinView: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(emailLabel,
                         emailTextField,
                         emailErrorLabel,
                         passwordLabel,
                         passwordTextField,
                         passwordErrorLabel,
                         sneakersSizeLabel,
                         sneakersSizeButton,
                         signupButton)
    }
    
    func setupConstraints() {
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
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
        
        sneakersSizeLabel.snp.makeConstraints {
            $0.top.equalTo(passwordErrorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(20)
        }
        
        sneakersSizeButton.snp.makeConstraints {
            $0.top.equalTo(sneakersSizeLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(sneakersSizeButton.snp.bottom).offset(10)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.width.equalTo(signupButton.snp.height).multipliedBy(7 / 1)
        }
    }
    
    func viewConfigure() {
        self.backgroundColor = .white
    }
}
