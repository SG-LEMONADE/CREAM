//
//  ListView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import UIKit

final class ProductListView: UIView {
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var shopCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        return collectionView
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

extension ProductListView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(shopCollectionView, indicatorView)
    }
    
    func setupConstraints() {
        shopCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        indicatorView.snp.makeConstraints {
            $0.center.equalTo(shopCollectionView.snp.center)
        }
    }
}

