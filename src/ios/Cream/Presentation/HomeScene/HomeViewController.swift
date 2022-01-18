//
//  HomeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit
import SnapKit
import BetterSegmentedControl

class HomeViewController: UIViewController {
    
    private let banners: [String] = ["homebanner1",
                                     "homebanner2",
                                     "homebanner3",
                                     "homebanner4",
                                     "homebanner5",
                                     "homebanner6",
                                     "homebanner7"]
    
    private lazy var homeCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: createCompositionalLayout())
        return cv
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let info = sectionNumber % 2
            switch info {
            case 0:
                return self.createBannerSection()
            case 1:
                return self.createItemListSection()
            default:
                return self.thirdLayoutSection()
            }
        }
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
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
    
    private func createItemListSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(0.58))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(580))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 20, trailing: 0)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                          heightDimension: .estimated(50)),
                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                        alignment: .topLeading)
        ]
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
    
    private func configureSegmentedControl() {
        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0, y: 0, width: 200.0, height: 30.0),
            segments: LabelSegment.segments(withTitles: ["투데이", "발매정보"],
                                            normalTextColor: .systemGray4,
                                            selectedTextColor: .black),
            options:[.backgroundColor(.white),
                     .indicatorViewBackgroundColor(UIColor(red: 0.36, green: 0.38, blue: 0.87, alpha: 1.00)),
                     .cornerRadius(3.0),
                     .animationSpringDamping(1.0),
                     .indicatorViewBorderWidth(1.0)
                    ]
        )
        navigationSegmentedControl.addTarget(self,
                                             action: #selector(navigationSegmentedControlValueChanged),
                                             for: .valueChanged)
        
        navigationItem.titleView = navigationSegmentedControl
    }
    
    // MARK: - Action handlers
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("first")
            if #available(iOS 13.0, *) {
                view.backgroundColor = .systemGray5
            } else {
                view.backgroundColor = .white
            }
        } else {
            print("second")
            view.backgroundColor = .darkGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
        applyViewSettings()
    }
    
    func configureCollectionView() {
        homeCollectionView.register(ShopBannerCell.self,
                                    forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
        homeCollectionView.register(SizeListCell.self,
                                    forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        homeCollectionView.register(HomeViewItemCell.self,
                                    forCellWithReuseIdentifier: HomeViewItemCell.reuseIdentifier)
        homeCollectionView.register(HomeViewCategoryHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier)
    }
}

extension HomeViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(homeCollectionView)
    }
    
    func setupConstraints() {
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func viewConfigure() {
        configureSegmentedControl()
        configureCollectionView()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        }
        if section % 2 == 1 {
            return 40
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section % 2 == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell else
                                                                { return UICollectionViewCell() }
            cell.configure(banners[indexPath.item])
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewItemCell.reuseIdentifier,
                                                            for: indexPath) as? HomeViewItemCell else
                                                            { return UICollectionViewCell() }
        cell.configureTest()
        cell.backgroundColor = .orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier,
                                                                           for: indexPath) as? HomeViewCategoryHeaderView else
                                                                           { return UICollectionReusableView() }
        header.configure("\(Int.random(in: 0...100))")
        return header
    }
}

