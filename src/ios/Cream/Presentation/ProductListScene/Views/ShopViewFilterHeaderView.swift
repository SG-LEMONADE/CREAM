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
    
    private var filterRange = (0...7)
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension ShopViewFilterHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.setupNumberOfItemsInSection(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource?.setupCellForItemAt(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
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
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
    }
}

extension ShopViewFilterHeaderView: FilterChangeDelegate {
    func didChangeSelectedRow(with setting: SelectFilter) {
        guard let category = setting.category,
              let type = FilterHeaderCategory(rawValue: category)
        else {
            if let firstCell = filterCollectionView.cellForItem(at: IndexPath.init(item: 0, section: 0)) as? FilterCell {
                firstCell.titleLabel.attributedText = getAttachment(color: .black)
            }
            filterRange.forEach {
                filterCollectionView.deselectItem(at: .init(item: $0, section: .zero), animated: false)
            }
            return
        }
        
        if let selectedIndex = filterCollectionView.indexPathsForSelectedItems?.first {
            if selectedIndex != type.headerIndexPath {
                filterCollectionView.selectItem(at: type.headerIndexPath,
                                                animated: false, scrollPosition: .centeredHorizontally)
                filterCollectionView.delegate?.collectionView?(filterCollectionView, didSelectItemAt: type.headerIndexPath)
            }
        }
    }
    
    private func getAttachment(color: UIColor) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "checklist")
        attachment.image = attachment.image?.withTintColor(color)
        return NSAttributedString(attachment: attachment)
    }
}
