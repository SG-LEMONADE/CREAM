//
//  LoginViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit
import Toast_Swift

final class LoginViewController: DIViewController<LoginViewModelInterface> {
    
    private lazy var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureActions()
        setupNavigationBarItem()
        setupTextField()
        setupKeyboardNotification()
    }
    
    private func setupTextField() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    private func setupNavigationBarItem() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(closeUserModal))
        navigationItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = navigationItem
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func bindViewModel() {
        loginView.emailTextField.bind { [weak self] email in
            self?.viewModel.validateEmail(email)
        }
        
        loginView.passwordTextField.bind { [weak self] password in
            self?.viewModel.validatePassword(password)
        }
        
        viewModel.emailMessage.bind { [weak self] message in
            self?.loginView.emailErrorLabel.text = message
            self?.loginView.emailErrorLabel.isHidden = false
            if ValidationHelper.State(rawValue: message) == .valid {
                self?.loginView.emailLabel.textColor = .black
                self?.loginView.emailTextField.setUnderlineViewColor(.systemGray6)
            } else {
                self?.loginView.emailLabel.textColor = .red
                self?.loginView.emailTextField.setUnderlineViewColor(.red)
            }
        }
        
        viewModel.passwordMessage.bind { [weak self] message in
            self?.loginView.passwordErrorLabel.text = message
            self?.loginView.passwordErrorLabel.isHidden = false
            if ValidationHelper.State(rawValue: message) == .valid {
                self?.loginView.passwordLabel.textColor = .black
                self?.loginView.passwordTextField.setUnderlineViewColor(.systemGray6)
            } else {
                self?.loginView.passwordLabel.textColor = .red
                self?.loginView.passwordTextField.setUnderlineViewColor(.red)
            }
        }
        
        viewModel.isLoginAvailable.bind { [weak self] value in
            if value == true {
                self?.loginView.loginButton.isEnabled = true
                self?.loginView.loginButton.backgroundColor = .black
            } else {
                self?.loginView.loginButton.isEnabled = false
                self?.loginView.loginButton.backgroundColor = .systemGray5
            }
        }
    }
    
    func configureActions() {
        loginView.loginButton.addTarget(self,
                                        action: #selector(didTapLoginButton),
                                        for: .touchUpInside)
        loginView.joinButton.addTarget(self,
                                       action: #selector(didTapJoinButton),
                                       for: .touchUpInside)
        loginView.findIDButton.addTarget(self,
                                         action: #selector(didTapFindIDButton),
                                         for: .touchUpInside)
        loginView.findPasswordButton.addTarget(self,
                                               action: #selector(didTapFindPasswordButton),
                                               for: .touchUpInside)
    }
}

// MARK: - UserActions
extension LoginViewController {
    
    @objc
    private func didTapLoginButton() {
        loginView.indicatorView.startAnimating()
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else {
                  return
              }
        
        self.viewModel.confirmUser(email: email, password: password) { result in
            DispatchQueue.main.async { [weak self] in
                self?.loginView.indicatorView.stopAnimating()
            }
            switch result {
            case .success(_):
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view.makeToast(error.userMessage, duration: 1.5, position:.center)
                }
            }
        }
    }
    
    @objc
    private func didTapJoinButton() {
        guard let baseURL = URL(string: Integrator.gateWayURL)
        else { fatalError() }
    
        let config: NetworkConfigurable                 = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService: NetworkService              = DefaultNetworkService(config: config)
        let dataTransferService: DataTransferService    = DefaultDataTransferService(with: networkService)
        let repository: UserRepositoryInterface         = UserRepository(dataTransferService: dataTransferService)
        let usecase: UserUseCaseInterface               = UserUseCase(repository)
        let viewModel: JoinViewModel                    = JoinViewModel(usecase: usecase)
        let joinViewController: JoinViewController      = JoinViewController(viewModel)
        
        navigationController?.pushViewController(joinViewController, animated: true)
    }
    
    @objc
    private func didTapFindIDButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("해당 기능은 아직 구현되지 않았어요!",
                                 duration: 1.5,
                                 position: .top)
        }
    }
    
    @objc
    private func didTapFindPasswordButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("해당 기능은 아직 구현되지 않았어요!",
                                 duration: 1.5,
                                 position: .top)
        }
    }
    
    @objc
    func closeUserModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        view.frame.origin.y = -150
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        view.frame.origin.y = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
