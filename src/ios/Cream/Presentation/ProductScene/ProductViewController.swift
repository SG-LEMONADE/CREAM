//
//  ProductViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {

    private var currentBanner: Int = 0
    private var viewModel = ProductsViewModel()
    
    enum Constraint {
        static let verticalInset: CGFloat = 20
        static let horizontalInset: CGFloat = 20
    }
    
    private lazy var shopCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        applyViewSettings()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.shopCollectionView.dataSource = self
        self.shopCollectionView.delegate = self
        
        shopCollectionView.register(ShopBannerCell.self,
                                    forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
        shopCollectionView.register(SizeListCell.self,
                                    forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        shopCollectionView.register(HomeViewItemCell.self,
                                    forCellWithReuseIdentifier: HomeViewItemCell.reuseIdentifier)
        shopCollectionView.register(ShopViewFilterHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: ShopViewFilterHeaderView.reuseIdentifier)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.firstLayoutSection()
            case 1:
                return self.secondLayoutSection()
            default:
                return self.thirdLayoutSection()
            }
        }
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
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0)
        
        let sectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .absolute(60))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        header.pinToVisibleBounds = true
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

extension ProductViewController {
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    func bannerMove() {
        currentBanner += 1
        shopCollectionView.scrollToItem(at: NSIndexPath(item: currentBanner, section: 0) as IndexPath, at: .bottom, animated: true)
        
        if self.currentBanner == viewModel.banners.count-1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                self.scrollTofirstIndex()
            }
        }
    }
    
    func scrollTofirstIndex() {
        shopCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: false)
        currentBanner = 0
    }
}

extension ProductViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(shopCollectionView)
    }
    
    func setupConstraints() {
        shopCollectionView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.bottom.equalTo(view)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
        }
    }
}

extension ProductViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.banners.count
        default:
            return 50
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            
            cell.configure(viewModel.banners[indexPath.item])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewItemCell.reuseIdentifier,
                                                                for: indexPath) as? HomeViewItemCell
            else { return UICollectionViewCell() }
            cell.configureTest()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: ShopViewFilterHeaderView.reuseIdentifier,
                                                                           for: indexPath) as? ShopViewFilterHeaderView else
                                                                           { return UICollectionReusableView() }
        header.delegate = self
        header.dataSource = self
        return header
    }
}

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let nextVC = ItemViewController.init(ItemViewModel())
            nextVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension ProductViewController: ShopViewFilterHeaderViewDelegate {
    func setupSizeForItemAt(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifer,
                                                                  for: indexPath) as? FilterCell else
                                                                  { return .zero }
        
        cell.configure(viewModel.categories[indexPath.item])
        cell.titleLabel.sizeToFit()
        
        var cellWidth = cell.sizeThatFits(cell.titleLabel.frame.size).width + Constraint.horizontalInset
        let cellHeight = cell.sizeThatFits(cell.titleLabel.frame.size).height + Constraint.verticalInset
        
        if indexPath.item == 2 {
            cellWidth = 2
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func didSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.categories[indexPath.item])
    }
}

extension ProductViewController: ShopViewFilterHeaderViewDataSource {
    func setupNumberOfItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func setupCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterImageCell.reuseIdentifier, for: indexPath) as? FilterImageCell
            else { return UICollectionViewCell() }
            cell.configure("slider")
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifer, for: indexPath) as? FilterCell
        else { return UICollectionViewCell() }
        
        cell.configure(viewModel.categories[indexPath.item])
        cell.titleLabel.sizeToFit()
        
        if indexPath.item == 2 {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
}
