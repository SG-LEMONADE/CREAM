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
    
    private lazy var tradeContainerView: TradeContainerView = {
        let tcv = TradeContainerView()
        return tcv
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
        self.view.addSubviews(ItemInfoListView, tradeContainerView)
    }
    
    func setupConstraints() {
        ItemInfoListView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        tradeContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.ItemInfoListView.snp.bottom)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(70)
        }
        self.view.bringSubviewToFront(tradeContainerView.buyButton)
    }
    
    func viewConfigure() {
        configureCollectionView()
        configureUserEvent()
        self.tradeContainerView.wishButton.configure(1000)
    }
}

// MARK: User Event
extension ItemViewController {
    func configureUserEvent() {
        tradeContainerView.wishButton.addTarget(self, action: #selector(didTapWishButton), for: .touchUpInside)
        tradeContainerView.buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        tradeContainerView.sellButton.addTarget(self, action: #selector(didTapSellButton), for: .touchUpInside)
    }
    
    @objc
    func didTapWishButton() {
        print(#function)
    }
    
    @objc
    func didTapBuyButton() {
        let sizeViewController = TradeViewController()
        self.present(sizeViewController, animated: true)
    }
    
    @objc
    func didTapSellButton() {
        let sizeViewController = TradeViewController()
        self.present(sizeViewController, animated: true)
    }
}

extension ItemViewController {
    func configureCollectionView() {
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = .init(top: 0, leading: 5, bottom: 15, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func configureDeliverySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.45))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 0
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.45))
        
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .fractionalWidth(0.8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)
        
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
            return 3
        case 2:
            return 4
        case 6:
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
            cell.delegate = self
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleaseInfoCell.reuseIdentifier,
                                                                for: indexPath) as? ReleaseInfoCell
            else { return UICollectionViewCell() }
            cell.configure("release cell")
            
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .red
            cell.configure("banner1")
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .red
            cell.configure("banner2")
            return cell
            
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewItemCell.reuseIdentifier,
                                                                for: indexPath) as? HomeViewItemCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .systemGray
            cell.configureTest()
            
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
    // TODO: Button Tap 이후, 상품에 해당하는 사이즈 가져오기
    func didTapSizeButton() {
        let nextVC = SizeListViewController(DefaultSizeListViewModel())
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: false)
    }
}
