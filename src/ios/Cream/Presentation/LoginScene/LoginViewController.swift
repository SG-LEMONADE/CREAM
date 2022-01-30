//
//  LoginViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/26.
//

import UIKit

final class LoginViewController: BaseDIViewController<LoginViewModel> {
    
    private lazy var loginView = LoginView()
    
    override init(_ viewModel: LoginViewModel) {
        super.init(viewModel)
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        bindViewModel()
        configureActions()
        setupNavigationBarItem()
    }
    
    func bindViewModel() {
        loginView.emailTextField.bind { [weak self] email in
            self?.viewModel.validateEmail(email)
        }
        
        loginView.passwordTextField.bind { [weak self] password in
            self?.viewModel.validatePassword(password)
        }
        
        self.viewModel.emailMessage.bind { [weak self] message in
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
        
        self.viewModel.passwordMessage.bind { [weak self] message in
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
        
        self.viewModel.isLoginAvailable.bind { [weak self] value in
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
        loginView.joinButton.addTarget(self, action: #selector(didTapJoinButton), for: .touchUpInside)
        loginView.findIDButton.addTarget(self, action: #selector(didTapFindIDButton), for: .touchUpInside)
        loginView.findPasswordButton.addTarget(self, action: #selector(didTapFindPasswordButton), for: .touchUpInside)
    }
    
    private func setupNavigationBarItem() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(closeUserModal))
        navigationItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = navigationItem
        
    }
    
    @objc
    func closeUserModal() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController {
    @objc
    private func didTapLoginButton() {
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else {
                  return
              }
        print("\(email) \(password)")
        self.viewModel.confirmUser(email: email, password: password) { result in
            print("Hi")
        }
    }
    
    @objc
    private func didTapJoinButton() {
        guard let baseURL = URL(string: "http://ec2-13-125-85-156.ap-northeast-2.compute.amazonaws.com:8081")
        else { fatalError() }
    
        let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService: NetworkService = DefaultNetworkService(config: config)
        let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
        let repository: UserRepositoryInterface = UserRepository(dataTransferService: dataTransferService)
        let usecase: UserUseCaseInterface = UserUseCase(repository)
        let viewModel: JoinViewModel = DefaultJoinViewModel(usecase: usecase)
        let nextVC = JoinViewController(viewModel)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    private func didTapFindIDButton() {
        guard let baseURL = URL(string: "http://ec2-13-125-85-156.ap-northeast-2.compute.amazonaws.com:8081")
        else { fatalError() }
    
        let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService: NetworkService = DefaultNetworkService(config: config)
        let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
        let repository: UserRepositoryInterface = UserRepository(dataTransferService: dataTransferService)
        let usecase: UserUseCaseInterface = UserUseCase(repository)
        let viewModel: JoinViewModel = DefaultJoinViewModel(usecase: usecase)
        let nextVC = JoinViewController(viewModel)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    private func didTapFindPasswordButton() {
        guard let baseURL = URL(string: "http://ec2-13-125-85-156.ap-northeast-2.compute.amazonaws.com:8081")
        else { fatalError() }
    
        let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService: NetworkService = DefaultNetworkService(config: config)
        let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
        let repository: UserRepositoryInterface = UserRepository(dataTransferService: dataTransferService)
        let usecase: UserUseCaseInterface = UserUseCase(repository)
        let viewModel: JoinViewModel = DefaultJoinViewModel(usecase: usecase)
        let nextVC = JoinViewController(viewModel)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
