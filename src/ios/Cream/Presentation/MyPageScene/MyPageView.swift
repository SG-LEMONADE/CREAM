//
//  MyPageView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/11.
//

import UIKit

class MyPageView: UIView {
    lazy var userTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(userTableView)
    }
    
    func setupConstraints() {
        userTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        userTableView.sectionFooterHeight = 10
        userTableView.rowHeight = UITableView.automaticDimension
    }
}
