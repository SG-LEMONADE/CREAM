//
//  NavigateMenuBaseController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/09.
//

import UIKit

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
                return HomeViewController()
            case .shop:
                return ProductViewController()
            case .my:
                return MyPageViewController()
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
        tabBar.isTranslucent = false
    }
    
    func setupViewControllers() {
        InnerViewType.allCases.forEach { tab in
            let rootNavigationViewController = UINavigationController(rootViewController: tab.viewController)
            rootNavigationViewController.tabBarItem = configureTabBarItem(config: tab)
            let test = UINavigationController()
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
        let isLogout = true
        
        if let naviVC = viewController as? UINavigationController,
           let _ = naviVC.viewControllers.first as? MyPageViewController {
            if isLogout {
                let loginViewController = SigninViewController()
                let navigationViewController = UINavigationController(rootViewController: loginViewController)
                navigationViewController.modalPresentationStyle = .fullScreen
                tabBarController.present(navigationViewController, animated: true, completion: nil)
                
                return false
            }
        }
        return true
    }
}
//        if let controller = viewController is UINavigationController {
//            let loginViewController = SigninViewContUINavigationController(rootViewController: tab.viewController)roller()
//            let navigationViewController = UINavigationController(rootViewController: loginViewController)
//            navigationViewController.modalPresentationStyle = .fullScreen
//            tabBarController.present(navigationViewController, animated: true, completion: nil)
//            return false
//        }
//        if tabBarController.selectedIndex == 2 && isLogout {
//            let loginViewController = SigninViewController()
//            let navigationViewController = UINavigationController(rootViewController: loginViewController)
//            navigationViewController.modalPresentationStyle = .fullScreen
//            tabBarController.present(navigationViewController, animated: true, completion: nil)
//            return false
//        }


extension NavigateMenuBaseController {
    func configureTabBarItem(config: InnerViewType) -> UITabBarItem {
        let item = UITabBarItem(title: config.title, image: config.image, selectedImage: config.selectedImage)
        item.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return item
    }
}
