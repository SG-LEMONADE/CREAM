//
//  MyPageViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    private lazy var userTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        applyViewSettings()
    }
}

extension MyPageViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(userTableView)
    }
    
    func setupConstraints() {
        userTableView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.bottom.equalTo(self.view)
            $0.leading.equalTo(self.view)
            $0.trailing.equalTo(self.view)
        }
    }
}
