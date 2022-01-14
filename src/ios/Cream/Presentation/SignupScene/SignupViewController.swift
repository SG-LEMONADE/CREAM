//
//  SignupViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/12.
//

import UIKit
import SnapKit

final class SignupViewController: UIViewController {
    
    private enum ViewMessage: String, CustomStringConvertible {
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
    
    private lazy var sneakersSizeLabel: UILabel = {
        let label = UILabel()
        label.text = ViewMessage.sneakersSizeLabel.description
        label.font = label.font.withSize(12)
        return label
    }()
    
    private lazy var emailTextField: BindingTextField = {
        let emailField = BindingTextField(frame: .zero)
        emailField.font?.withSize(15)
        
        emailField.bind { [weak self] email in
            
        }
        return emailField
    }()
    
    private lazy var passwordTextField: BindingTextField = {
        let passwordField = BindingTextField()
        passwordField.font?.withSize(15)
        
        return passwordField
    }()
    
    private lazy var sneakersSizeField: BindingTextField = {
        let sizeTextField = BindingTextField()
        sizeTextField.placeholder = "선택하세요"
        
        let magnifyingGlassButton = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        magnifyingGlassButton.setTitle("▼", for: .normal)
        magnifyingGlassButton.setTitleColor(.black, for: .normal)
        
        sizeTextField.rightView = magnifyingGlassButton
        sizeTextField.rightViewMode = .always
        
        magnifyingGlassButton.addTarget(self, action: #selector(selectSneakersSize), for: .touchUpInside)
        
        return sizeTextField
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
    
    
    private lazy var signupButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 10
        button.setTitle(ViewMessage.signupButton.description, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        button.backgroundColor = .systemGray5
        button.addTarget(self, action: #selector(signup), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.backgroundColor = .white
        applyViewSettings()
    }
}

extension SignupViewController {
    @objc
    func selectSneakersSize() {
        let sizeSelectViewController = SizeModalCollectionViewController()
        sizeSelectViewController.modalPresentationStyle = .overCurrentContext
        self.present(sizeSelectViewController, animated: false)
    }
    
    @objc
    func signup() {
        print("회원 가입")
    }
}

extension SignupViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(emailLabel,
                         emailTextField,
                         emailErrorLabel,
                         passwordLabel,
                         passwordTextField,
                         passwordErrorLabel,
                         sneakersSizeLabel,
                         sneakersSizeField,
                         signupButton)
    }
    
    func viewConfigure() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupConstraints() {
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
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
        sneakersSizeLabel.snp.makeConstraints {
            $0.top.equalTo(passwordErrorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(20)
        }
        
        sneakersSizeField.snp.makeConstraints {
            $0.top.equalTo(sneakersSizeLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(sneakersSizeField.snp.bottom).offset(10)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
            $0.width.equalTo(signupButton.snp.height).multipliedBy(7 / 1)
        }
    }
}
