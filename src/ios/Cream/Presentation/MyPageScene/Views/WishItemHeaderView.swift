//
//  WishItemHeaderView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import UIKit
import SnapKit

class WishItemHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = "\(WishItemHeaderView.self)"
    
    var wishListAction: (() -> Void)?
    
    private lazy var userInfoValueLabel: UILabel = {
        let label = UILabel()
        label.text = "일반 회원"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 등급"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var wishCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var wishLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 상품"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userInfoValueLabel,
                                                       userInfoLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var wishStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wishCountLabel,
                                                       wishLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userStackView,
                                                       wishStackView])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWishList))
        wishStackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapWishList() {
        wishListAction?()
    }
}

extension WishItemHeaderView: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubviews(containerStackView)
    }
    
    func setupConstraints() {
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        setupUserAction()
    }
}
