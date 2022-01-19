//
//  ViewConfiguration.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import Foundation

protocol ViewConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func viewConfigure()
}

extension ViewConfiguration {
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        viewConfigure()
    }
    
    func viewConfigure() { }
}
