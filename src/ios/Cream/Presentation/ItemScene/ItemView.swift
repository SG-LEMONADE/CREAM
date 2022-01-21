//
//  ItemView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

//import UIKit
//import SnapKit

//class ItemView: UIView {
//    lazy var ItemInfoListView: UICollectionView = {
//        let cv = UICollectionView(frame: .zero,
//                                  collectionViewLayout: configureCollectionViewLayout())
//        return cv
//    }()
//    
//    lazy var buyButton: TradeButton = {
//        let button = TradeButton(tradeType: .buy)
//        return button
//    }()
//    
//    lazy var sellButton: TradeButton = {
//        let button = TradeButton(tradeType: .sell)
//        return button
//    }()
//
//    lazy var wishButton: VerticalButton = {
//        let button = VerticalButton.init(frame: .zero)
//        button.imageView?.image = UIImage(systemName: "bookmark")
//        button.titleLabel?.text = "찜 목록 개수"
//        return button
//    }()
//    
//    lazy var tradeStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [buyButton, sellButton])
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.spacing = 5
//        return stackView
//    }()
//    
//    lazy var containerStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [wishButton, tradeStackView])
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        return stackView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        applyViewSettings()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        applyViewSettings()
//    }
//}
//
//// MARK: CollectionViewLayout
//extension ItemView {
//    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
//        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
//            switch section {
//            case 0:
//                return self.configureImageSectionLayout()
//            case 1:
//                return self.configureItemInfoSectionLayout()
//            case 2:
//                return self.configureReleaseSectionLayout()
//            case 3:
//                return self.configureDeliverySectionLayout()
//            case 4:
//                return self.configureAdvertiseSectionLayout()
//            case 5:
//                return self.configurePriceChartSectionLayout()
//            default:
//                return self.configureSimilarItemSectionLayout()
//            }
//        }
//    }
//
//    private func configureImageSectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalWidth(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 15
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .fractionalWidth(1))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//
//    private func configureItemInfoSectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalWidth(0.52))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 15
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .fractionalWidth(0.52))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//
//    private func configureReleaseSectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
//                                              heightDimension: .fractionalWidth(0.3))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 15
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .fractionalWidth(0.35))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//
//    private func configureDeliverySectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalWidth(0.3))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 0
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .fractionalWidth(0.3))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//
//    private func configureAdvertiseSectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalWidth(0.256))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 0
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .fractionalWidth(0.256))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//    
//    private func configurePriceChartSectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalWidth(1.2))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets.bottom = 15
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .fractionalWidth(1.2))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        return section
//    }
//    
//    private func configureSimilarItemSectionLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
//                                              heightDimension: .fractionalHeight(0.464))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 5)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .estimated(464))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 20, trailing: 0)
//        section.boundarySupplementaryItems = [
//            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
//                                                                          heightDimension: .estimated(40)),
//                                                        elementKind: UICollectionView.elementKindSectionHeader,
//                                                        alignment: .topLeading)
//        ]
//        return section
//    }
//}
//
//extension ItemView: ViewConfiguration {
//    func buildHierarchy() {
//        self.addSubviews(ItemInfoListView, containerStackView)
//    }
//    
//    func setupConstraints() {
//        ItemInfoListView.snp.makeConstraints {
////            $0.top.equalTo(self.snp.top)
////            $0.leading.equalTo(self.snp.leading)
////            $0.trailing.equalTo(self.snp.trailing)
//            $0.top.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(self.containerStackView.snp.top)
//        }
//        
//        containerStackView.snp.makeConstraints {
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//    
//    func viewConfigure() {
//        collectionViewConfigure()
//    }
//    
//    func collectionViewConfigure() {
//        ItemInfoListView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.reuseIdentifier)
//        ItemInfoListView.register(ReleaseInfoCell.self, forCellWithReuseIdentifier: ReleaseInfoCell.reuseIdentifier)
//        ItemInfoListView.register(ShopBannerCell.self, forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
//        ItemInfoListView.register(HomeViewItemCell.self, forCellWithReuseIdentifier: HomeViewItemCell.reuseIdentifier)
//    }
//}
//
