//
//  FilterView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/09.
//

import UIKit
import SnapKit

final class FilterView: UIView {
    lazy var filterTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.contentHorizontalAlignment = .center
        button.setTitle("결과보기", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(filterTableView, searchButton)
    }
    
    func setupConstraints() {
        filterTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(searchButton.snp.top).offset(10)
        }
        
        searchButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalTo(self.snp.leading).inset(10)
            $0.trailing.equalTo(self.snp.trailing).inset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}

