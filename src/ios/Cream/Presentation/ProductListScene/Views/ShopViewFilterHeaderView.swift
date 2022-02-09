//
//  ShopViewFilterHeaderView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit
import SnapKit

protocol ShopViewFilterHeaderViewDelegate: AnyObject {
    func setupSizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func didSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

protocol ShopViewFilterHeaderViewDataSource: AnyObject {
    func setupNumberOfItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func setupCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

final class ShopViewFilterHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "\(ShopViewFilterHeaderView.self)"
    
    weak var delegate: ShopViewFilterHeaderViewDelegate?
    weak var dataSource: ShopViewFilterHeaderViewDataSource?
    
    private lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.register(FilterImageCell.self, forCellWithReuseIdentifier: FilterImageCell.reuseIdentifier)
        cv.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseIdentifer)
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

extension ShopViewFilterHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.setupNumberOfItemsInSection(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource?.setupCellForItemAt(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
}

extension ShopViewFilterHeaderView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return delegate?.setupSizeForItemAt(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(collectionView, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item == 2 ? false : true
    }
}

// MARK: - ViewConfiguration
extension ShopViewFilterHeaderView: ViewConfiguration {
    func setupConstraints() {
        filterCollectionView.frame = bounds
    }

    func buildHierarchy() {
        addSubviews(filterCollectionView)
    }
    func viewConfigure() {
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.systemGray2.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
    }
}
