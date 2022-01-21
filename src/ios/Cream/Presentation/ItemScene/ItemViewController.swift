//
//  ItemViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit
import SnapKit

protocol FooterScrollDelegate: AnyObject {
    func didScrollTo(_ page: Int)
}

// MARK: CollectionViewLayout
class ItemViewController: UIViewController {
    // MARK: Properties
    private var viewModel: ItemViewModel? = nil
    
    weak var delegate: FooterScrollDelegate?
    
    private var item: Int = 0 {
        didSet {
            self.delegate?.didScrollTo(item)
        }
    }
    private lazy var ItemInfoListView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: configureCollectionViewLayout())
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
        button.titleLabel?.text = "1,234"
        button.backgroundColor = .yellow
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
        stackView.backgroundColor = .white
        return stackView
    }()
    
    // MARK: Init
    init(_ viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        applyViewSettings()
        view.backgroundColor = .white
    }
    
    func configureDelegate() {
        self.ItemInfoListView.delegate = self
        self.ItemInfoListView.dataSource = self
    }
}

extension ItemViewController: ViewConfiguration {
    func buildHierarchy() {
        self.view.addSubviews(ItemInfoListView, containerStackView)
    }
    
    func setupConstraints() {
        ItemInfoListView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.containerStackView.snp.top).offset(-10)
        }
        
        containerStackView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(10)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.height.equalTo(50)
        }
        
        wishButton.snp.makeConstraints {
            $0.width.equalTo(self.tradeStackView).multipliedBy(0.2)
        }
        
        wishButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func viewConfigure() {
        collectionViewConfigure()
    }
}

extension ItemViewController {
    func collectionViewConfigure() {
        ItemInfoListView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.reuseIdentifier)
        ItemInfoListView.register(ReleaseInfoCell.self, forCellWithReuseIdentifier: ReleaseInfoCell.reuseIdentifier)
        ItemInfoListView.register(ShopBannerCell.self, forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
        ItemInfoListView.register(HomeViewItemCell.self, forCellWithReuseIdentifier: HomeViewItemCell.reuseIdentifier)
        ItemInfoListView.register(HomeViewCategoryHeaderView.self,
                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                  withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier)
        ItemInfoListView.register(PageControlFooterView.self,
                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                  withReuseIdentifier: PageControlFooterView.reuseIdentifier)
    }
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.configureImageSectionLayout()
            case 1:
                return self.configureItemInfoSectionLayout()
            case 2:
                return self.configureReleaseSectionLayout()
            case 3:
                return self.configureDeliverySectionLayout()
            case 4:
                return self.configureAdvertiseSectionLayout()
            case 5:
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
        item.contentInsets.bottom = -20
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                          heightDimension: .absolute(10)),
                                                        elementKind: UICollectionView.elementKindSectionFooter,
                                                        alignment: .bottom)
        ]
        
        section.visibleItemsInvalidationHandler = { items, contentOffset, environment in
            let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
            if currentPage != self.item {
                self.item = currentPage
            }
        }
        return section
    }
    
    private func configureItemInfoSectionLayout() -> NSCollectionLayoutSection {
        print(#function)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.52))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.top = 20
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.52))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func configureReleaseSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                              heightDimension: .fractionalWidth(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func configureDeliverySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 0
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func configureAdvertiseSectionLayout() -> NSCollectionLayoutSection {
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
    
    private func configurePriceChartSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func configureSimilarItemSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                              heightDimension: .fractionalHeight(0.464))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(464))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func configureSectionLayout(_ itemSize: NSCollectionLayoutSize,
                                        _ itemContentInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                                        _ groupSize: NSCollectionLayoutSize,
                                        _ groupContenInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                                        _ supplementaryItems: NSCollectionLayoutBoundarySupplementaryItem...) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = itemContentInsets
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = groupContenInsets
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                          heightDimension: .estimated(40)),
                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                        alignment: .topLeading)
        ]
        return section
    }
}

extension ItemViewController: UICollectionViewDelegate {
    
}

extension ItemViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier,
                                                                                   for: indexPath) as? HomeViewCategoryHeaderView else
            { return UICollectionReusableView() }
            headerView.configure("\(Int.random(in: 0...100))")
            headerView.backgroundColor = .green
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PageControlFooterView.reuseIdentifier,
                                                                               for: indexPath) as? PageControlFooterView else
            { return UICollectionReusableView() }
            
            self.delegate = footer
            
            viewModel.flatMap {
                footer.configure($0.count)
            }
            
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            print("section0")
            return 3
        case 2:
            print("section2")
            return 4
        case 6:
            print("section6")
            return 5
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .lightGray
            cell.configure(viewModel?.imageUrls[indexPath.item] ?? "banner1")
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.reuseIdentifier,
                                                                for: indexPath) as? ItemInfoCell
            else { return UICollectionViewCell() }
            cell.configure("itemInfo cell")
            print("function 1")
            cell.delegate = self
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleaseInfoCell.reuseIdentifier,
                                                                for: indexPath) as? ReleaseInfoCell
            else { return UICollectionViewCell() }
            cell.configure("release cell")
            cell.backgroundColor = .magenta
            print("function 2")
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .red
            cell.configure("banner1")
            print("function 0")
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .red
            cell.configure("banner2")
            print("function 0")
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.configure("homeBanner5")
            return cell
        }
    }
}

extension ItemViewController: ItemInfoCellDelegate {
    func didTapSizeButton() {
        print("클릭 잘 되고 있음.")
        let nextVC = SizeListViewController()
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: false)
    }
}

