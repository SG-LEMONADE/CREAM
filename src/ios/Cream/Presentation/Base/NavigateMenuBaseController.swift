//
//  NavigateMenuBaseController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/09.
//

import UIKit

final class NavigateMenuBaseController: UITabBarController {
    internal enum TabBarType: String, CustomStringConvertible, CaseIterable {
        case home, shop, my
        var description: String {
            self.rawValue
        }
        
        var title: String {
            self.description.uppercased()
        }
        
        var image: UIImage? {
            return UIImage(named: String(describing: self))
        }

        var selectedImage: UIImage? {
            return UIImage(named: String(describing: self) + "Selected")
        }
        
        var viewController: UIViewController {
            switch self {
            case .home:
                return HomeViewController()
            case .shop:
                return ShopViewController()
            case .my:
                return MyPageViewController()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    func setupViewControllers() {
        var tabBarViewControllers: [UIViewController] = []
        
        TabBarType.allCases.forEach { tab in
            let rootNavigationViewController = UINavigationController(rootViewController: tab.viewController)
            rootNavigationViewController.tabBarItem = self.configureTabBarItem(config: tab)
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
}

extension NavigateMenuBaseController {
    func configureTabBarItem(config: TabBarType) -> UITabBarItem {
        let item = UITabBarItem.init(title: config.title, image: config.image, selectedImage: config.selectedImage)
        item.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return item
    }
}
