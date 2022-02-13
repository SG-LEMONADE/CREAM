//
//  ProductView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import UIKit

protocol BannerViewDelegate: AnyObject {
    func didReceivePageNumber(_ page: Int)
}

class ProductView: UIView {
    
    weak var delegate: BannerViewDelegate?
    
    lazy var ItemInfoListView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: configureCollectionViewLayout())
        return cv
    }()
    
    lazy var tradeContainerView: TradeContainerView = {
        let tcv = TradeContainerView()
        return tcv
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

// MARK: - ViewConfiguration
extension ProductView: ViewConfiguration {
    
    func buildHierarchy() {
        self.addSubviews(ItemInfoListView, tradeContainerView)
    }
    
    func setupConstraints() {
        ItemInfoListView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        tradeContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.ItemInfoListView.snp.bottom)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(70)
        }
        self.bringSubviewToFront(tradeContainerView.buyButton)
    }
    
    func viewConfigure() {
        self.backgroundColor = .white
        registerCollectionViewCell()
    }
}
