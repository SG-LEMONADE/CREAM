//
//  JoinViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit
import Toast_Swift

final class JoinViewController: DIViewController<JoinViewModelInterface> {

    private lazy var joinView = JoinView()
    
    override func loadView() {
        self.view = joinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureActions()
        setupNavigationBarItem()
        setupTextField()
    }
    
    func setupNavigationBarItem() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseButton))
        navigationItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = navigationItem
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTextField() {
        joinView.emailTextField.delegate = self
        joinView.passwordTextField.delegate = self
    }
    
    private func bindViewModel() {
        joinView.emailTextField.bind { [weak self] email in
            self?.viewModel.validateEmail(email)
        }
        
        joinView.passwordTextField.bind { [weak self] password in
            self?.viewModel.validatePassword(password)
        }
        
        viewModel.emailMessage.bind { [weak self]  message in
            self?.joinView.emailErrorLabel.text = message
            self?.joinView.emailErrorLabel.isHidden = false
            if ValidationHelper.State(rawValue: message) == .valid {
                self?.joinView.emailLabel.textColor = .black
                self?.joinView.emailTextField.setUnderlineViewColor(.systemGray6)
            } else {
                self?.joinView.emailLabel.textColor = .red
                self?.joinView.emailTextField.setUnderlineViewColor(.red)
            }
        }
        
        viewModel.passwordMessage.bind { [weak self] message in
            self?.joinView.passwordErrorLabel.text = message
            self?.joinView.passwordErrorLabel.isHidden = false
            if ValidationHelper.State(rawValue: message) == .valid {
                self?.joinView.passwordLabel.textColor = .black
                self?.joinView.passwordTextField.setUnderlineViewColor(.systemGray6)
            } else {
                self?.joinView.passwordLabel.textColor = .red
                self?.joinView.passwordTextField.setUnderlineViewColor(.red)
            }
        }
        
        viewModel.shoeSize.bind { [weak self] size in
            self?.joinView.sneakersSizeButton.setTitle("\(size)", for: .normal)
        }
        
        viewModel.isJoinAvailable.bind { [weak self] value in
            if value == true {
                self?.joinView.signupButton.isEnabled = true
                self?.joinView.signupButton.backgroundColor = .black
            } else {
                self?.joinView.signupButton.isEnabled = false
                self?.joinView.signupButton.backgroundColor = .systemGray5
            }
        }
    }
    
    func configureActions() {
        joinView.signupButton.addTarget(self,
                                        action: #selector(didTapSignupButton),
                                        for: .touchUpInside)
        joinView.sneakersSizeButton.addTarget(self,
                                              action: #selector(didSelectSneakersSize),
                                              for: .touchUpInside)
    }
}

// MARK: - UserActions
extension JoinViewController {
    
    @objc
    func didTapCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didSelectSneakersSize() {
        let sizeListViewModel: SizeListViewModel = SizeListViewModel()
        let sizeListViewController = SizeListViewController(sizeListViewModel)
        sizeListViewController.delegate = self
        sizeListViewController.modalPresentationStyle = .overCurrentContext
        self.present(sizeListViewController, animated: false)
    }
    
    @objc
    func didTapSignupButton() {
        guard let email = self.joinView.emailTextField.text,
              let password = self.joinView.passwordTextField.text,
              let size = self.joinView.sneakersSizeButton.titleLabel?.text,
              let sizeInt = Int(size)
        else { return }
        
        self.viewModel.addUser(email: email, password: password, shoesize: sizeInt) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "이메일 인증", message: "\(user.email)에서 메일을 확인해주세요.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "로그인 화면으로", style: .default, handler: {_ in
                        self?.navigationController?.popViewController(animated: true)
                    }))
                    self?.present(alertController, animated: true, completion: nil)
                }
            case .failure(let error):
                if error == .duplicatedEmail {
                    DispatchQueue.main.async { [weak self] in
                        self?.view.makeToast("이미 사용중인 이메일입니다.", duration: 1.5, position:.center)
                    }
                } else if error == .networkUnconnected {
                    DispatchQueue.main.async { [weak self] in
                        self?.view.makeToast("서버 문제로 회원가입에 실패했습니다.\n 개발자에게 문의해주세요.", duration: 1.5, position: .center)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate
extension JoinViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: SizeSelectDelegate
extension JoinViewController: SizeSelectDelegate {
    func configureShoesSize(_ size: Int) {
        self.viewModel.shoeSize.value = size
    }
}
