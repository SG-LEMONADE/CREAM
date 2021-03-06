//
//  DIViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/25.
//

import UIKit

class DIViewController<T>: UIViewController {
    var viewModel: T
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
