//
//  ProductListView+CompositionalLayout.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import UIKit

// MARK: - CollectionView Compositional Layout
extension ProductListView {
    enum SectionList: Int, CaseIterable {
        case banner, productList
    }
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(55))

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        header.pinToVisibleBounds = true
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [header]
        
         let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            guard let section = SectionList(rawValue: section)
            else { return nil }
             
            switch section {
            case .banner:
                return self.configureBannerSectionLayout()
            case .productList:
                return self.configureProductListSectionLayout()
            }
        }
        layout.configuration = config
        
        return layout
    }
    
    private func configureBannerSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.256))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 0
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.256))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func configureProductListSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(0.58))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(580))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 20, trailing: 0)
        
        let sectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .absolute(40))

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionSize,
                                                                 elementKind: UICollectionView.elementKindSectionFooter,
                                                                 alignment: .top)
        header.zIndex = 0
        section.boundarySupplementaryItems = [header]
        return section
    }
}
