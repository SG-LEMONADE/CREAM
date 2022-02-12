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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
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

// MARK: - CollectionView Compositional Layout
extension ProductListView {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(55))

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        header.pinToVisibleBounds = true
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [header]
        
         let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.firstLayoutSection()
            case 1:
                return self.secondLayoutSection()
            default:
                return self.thirdLayoutSection()
            }
        }
        layout.configuration = config
        
        return layout
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
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
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        
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
    
    private func thirdLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .fractionalWidth(0.35))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
