//
//  JoinViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit

final class JoinViewController: BaseDIViewController<JoinViewModel> {

    private lazy var joinView = JoinView()
    
    override init(_ viewModel: JoinViewModel) {
        super.init(viewModel)
    }
    
    override func loadView() {
        self.view = joinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        bindViewModel()
        configureActions()
        setupNavigationBarItem()
    }
    
    func bindViewModel() {
        joinView.emailTextField.bind { [weak self] email in
            self?.viewModel.validateEmail(email)
        }
        
        joinView.passwordTextField.bind { [weak self] password in
            self?.viewModel.validatePassword(password)
        }
        
        self.viewModel.emailMessage.bind { [weak self]  message in
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
        
        self.viewModel.passwordMessage.bind { [weak self] message in
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
        
        self.viewModel.shoeSize.bind { [weak self] size in
            self?.joinView.sneakersSizeButton.setTitle("\(size)", for: .normal)
        }
        
        self.viewModel.isJoinAvailable.bind { [weak self] value in
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
    
    func setupNavigationBarItem() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseButton))
        navigationItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = navigationItem
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
        let sizeListViewModel: SizeListViewModel = DefaultSizeListViewModel()
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
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "에러 발생", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "확인", style: .default))
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: SizeSelectDelegate
extension JoinViewController: SizeSelectDelegate {
    func configureShoesSize(_ size: Int) {
        self.viewModel.shoeSize.value = size
    }
}


