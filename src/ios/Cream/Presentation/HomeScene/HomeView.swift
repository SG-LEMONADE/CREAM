//
//  HomeView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/07.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    weak var delegate: FooterScrollDelegate?
    var item: Int = 0 {
        didSet {
            delegate?.didScrollTo(item)
        }
    }
    
    lazy var homeCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: configureCompositionalLayout())
        return cv
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

extension HomeView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(homeCollectionView)
    }
    
    func setupConstraints() {
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}
