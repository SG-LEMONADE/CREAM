//
//  MainTabBarController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/09.
//

import UIKit

final class MainTabBarController: UITabBarController {

    internal enum TabBarItem: String, CustomStringConvertible, CaseIterable {
        case home, style, shop, watch, my
        
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
            return UIImage(named: String(describing: self))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
