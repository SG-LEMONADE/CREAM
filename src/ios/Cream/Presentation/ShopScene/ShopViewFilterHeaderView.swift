//
//  ShopViewFilterHeaderView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit
import SnapKit

final class ShopViewFilterHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "\(ShopViewFilterHeaderView.self)"
    
    var numberOfCell = 10
    
    enum Constraint {
        static let verticalInset: CGFloat = 20
        static let horizontalInset: CGFloat = 20
    }
    
    let dataSource = ["  ", "럭셔리", " ", "스니커즈", "의류", "패션 잡화", "라이프", "테크"]
    
    lazy var filterCollectionView: UICollectionView = {
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
    
    func setupDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
}


extension ShopViewFilterHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterImageCell.reuseIdentifier, for: indexPath) as? FilterImageCell
            else { return UICollectionViewCell() }
            
            cell.configure("slider")
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifer, for: indexPath) as? FilterCell
        else {
            return UICollectionViewCell()
        }
        print(dataSource[indexPath.item])

        cell.configure(dataSource[indexPath.item])
        cell.titleLabel.sizeToFit()
        
        
        
        if indexPath.item == 1 {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
        guard let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifer,
                                                                  for: indexPath) as? FilterCell
        else { return .zero }
        
        cell.configure(dataSource[indexPath.item])
        cell.titleLabel.sizeToFit()
        
        var cellWidth = cell.sizeThatFits(cell.titleLabel.frame.size).width + Constraint.horizontalInset
        let cellHeight = cell.sizeThatFits(cell.titleLabel.frame.size).height + Constraint.verticalInset
        
        if indexPath.item == 2 {
            cellWidth = 2
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dataSource[indexPath.item])
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
}
