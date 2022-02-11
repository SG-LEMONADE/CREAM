//
//  NavigateMenuBaseController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/09.
//

import UIKit
import SwiftKeychainWrapper

final class NavigateMenuBaseController: UITabBarController {
    internal enum InnerViewType: String, CustomStringConvertible, CaseIterable {
        case home, shop, my
        
        var description: String {
            self.rawValue
        }
        
        var symbol: String {
            switch self {
            case .home:
                return "house"
            case .shop:
                return "cart"
            case .my:
                return "person"
            }
        }
        
        var title: String {
            self.description.uppercased()
        }
        
        var image: UIImage? {
            let image = UIImage(systemName: symbol)
            return image
        }
        
        var selectedImage: UIImage? {
            return UIImage(systemName: symbol + ".fill")
        }
        
        var viewController: UIViewController {
            switch self {
            case .home:
                guard let baseURL = URL(string: "http://1.231.16.189:8081")
                else { fatalError() }
                
                let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
                let networkService: NetworkService = DefaultNetworkService(config: config)
                let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
                let repository: HomeListRepositoryInterface = ProductRepository(dataTransferService: dataTransferService)
                let usecase: HomeListUseCaseInterface = HomeListUseCase(repository: repository)
                let viewModel: HomeListViewModel = DefaultHomeListViewModel(usecase)
                let homeViewController = HomeViewController(viewModel)
                return homeViewController
                
            case .shop:
                guard let baseURL = URL(string: "http://1.231.16.189:8081")
                else { fatalError() }
                
                let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
                let networkService: NetworkService = DefaultNetworkService(config: config)
                let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
                let repository: ProductRepositoryInterface = ProductRepository(dataTransferService: dataTransferService)
                let usecase: ProductUseCaseInterface = ProductUseCase(repository)
                let viewModel: ProductListViewModel = DefaultListViewModel(usecase)
                let listViewController = ProductListViewController(viewModel)
                
                return listViewController
            case .my:
                let viewModel: MyPageViewModel = DefaultMyPageViewModel()
                let mypageViewController = MyPageViewController(viewModel)
                
                return mypageViewController
            }
        }
    }
    var tabBarViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarColor()
        configureDelegate()
    }
    
    private func setupTabBarColor() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
    }
    
    func setupViewControllers() {
        InnerViewType.allCases.forEach { tab in
            let rootNavigationViewController = UINavigationController(rootViewController: tab.viewController)
            rootNavigationViewController.tabBarItem = configureTabBarItem(config: tab)
            tabBarViewControllers.append(rootNavigationViewController)
        }
        self.viewControllers = tabBarViewControllers
    }
}

extension NavigateMenuBaseController: UITabBarControllerDelegate {
    private func configureDelegate() {
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if let accessToken = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken) {
            return true
        }
        
        if let naviVC = viewController as? UINavigationController,
           (naviVC.viewControllers.first as? MyPageViewController != nil) {
            guard let baseURL = URL(string: "http://ec2-13-125-85-156.ap-northeast-2.compute.amazonaws.com:8081")
            else { fatalError() }
        
            let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
            let networkService: NetworkService = DefaultNetworkService(config: config)
            let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
            let repository: UserRepositoryInterface = UserRepository(dataTransferService: dataTransferService)
            let usecase: UserUseCaseInterface = UserUseCase(repository)
            let viewModel: LoginViewModel = DefaultLoginViewModel(usecase: usecase)
            let loginViewController = LoginViewController(viewModel)
            let navigationViewController = UINavigationController(rootViewController: loginViewController)
            
            navigationViewController.modalPresentationStyle = .fullScreen
            tabBarController.present(navigationViewController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}

extension NavigateMenuBaseController {
    func configureTabBarItem(config: InnerViewType) -> UITabBarItem {
        let item = UITabBarItem(title: config.title, image: config.image, selectedImage: config.selectedImage)
        item.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return item
    }
}
