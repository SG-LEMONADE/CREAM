//
//  ItemView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

import UIKit
import SnapKit

//enum ItemViewSection {
//    case
//}

class ItemView: UIView {
    private lazy var ItemInfoListView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    private lazy var buyButton: TradeButton = {
        let button = TradeButton(tradeType: .buy)
        return button
    }()
    
    private lazy var sellButton: TradeButton = {
        let button = TradeButton(tradeType: .sell)
        return button
    }()

    private lazy var wishButton: VerticalButton = {
        let button = VerticalButton.init(frame: .zero)
        button.imageView?.image = UIImage(systemName: "bookmark")
        button.titleLabel?.text = "찜 목록 개수"
        return button
    }()
    
    private lazy var tradeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyButton, sellButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wishButton, tradeStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
}

// MARK: CollectionViewLayout
extension ItemView {
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.configureImageSectionLayout()
            case 1:
                return self.configureItemSectionLayout()
            case 2:
                return self.configureInfoSectionLayout()
            case 3:
                return self.configurePriceChartSectionLayout()
            default:
                return self.configureSimilarItemSectionLayout()
            }
        }
    }

    private func configureImageSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }

    private func configureItemSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }

    private func configureInfoSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }

    private func configurePriceChartSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func configureSimilarItemSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.52))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.52))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}


class VerticalButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentHorizontalAlignment = .left
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerButtonImageAndTitle()
    }
    
    private func centerButtonImageAndTitle() {
        let titleSize = self.titleLabel?.frame.size ?? .zero
        let imageSize = self.imageView?.frame.size ?? .zero
        let spacing: CGFloat = 6.0
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),left: 0, bottom: 0, right:  -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
    }
}
