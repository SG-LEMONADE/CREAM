//
//  BaseViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
    }
    
    func buildHierarchy() { }
    func setupConstraints() { }
    func viewConfigure() { }
}

extension BaseViewController {
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        viewConfigure()
    }
}
