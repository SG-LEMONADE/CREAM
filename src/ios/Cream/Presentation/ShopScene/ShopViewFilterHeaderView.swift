//
//  ShopViewFilterHeaderView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit
import SnapKit

final class FilterCell: UICollectionViewCell {
    static let reuseIdentifer = "\(FilterCell.self)"
    
    static func fittingSize(availableHeight: CGFloat, data: String) -> CGSize {
        let cell = FilterCell()
        cell.configure(data)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        print(cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required))
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.showsExpansionTextWhenTruncated = true
        label.sizeToFit()
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemGray5
        layer.cornerRadius = frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    func configure(_ data: String) {
        self.titleLabel.text = data
    }
}

extension FilterCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

final class ShopViewFilterHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "\(ShopViewFilterHeaderView.self)"
    
    var numberOfCell = 10
    let dataSource = ["럭셔리", "스니커즈", "의류", "패션 잡화", "라이프", "테크"]
    
    lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
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
    
    //    func setupDelegate() {
    //        filterCollectionView.delegate = self
    //        filterCollectionView.dataSource = self
    //    }
}


extension ShopViewFilterHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dataSource.count)
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifer, for: indexPath) as? FilterCell
        else {
            return UICollectionViewCell()
        }
        print(dataSource[indexPath.item])
        cell.configure(dataSource[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
//        return FilterCell.fittingSize(availableHeight: 50, data: dataSource[indexPath.item])
        return CGSize(width: 100, height: 50)
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
