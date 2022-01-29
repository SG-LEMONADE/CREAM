//
//  BaseView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/27.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseView {
    func buildHierarchy() { }
    func setupConstraints() { }
    func viewConfigure() { }
    
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        viewConfigure()
    }
} 
