//
//  SettingView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import UIKit
import SnapKit

final class SettingView: UIView {
    lazy var settingTableView: UITableView = {
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

extension SettingView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(settingTableView)
    }
    
    func setupConstraints() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func viewConfigure() {
        settingTableView.backgroundColor = .white
    }
}
