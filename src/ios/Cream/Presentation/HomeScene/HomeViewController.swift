//
//  HomeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit
import SnapKit

class HomeListViewController: BaseDIViewController<HomeViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class HomeViewController: UIViewController {
    enum SectionInfo {
        case banner
        case itemList
    }
    
    private let viewModel = HomeViewModel.init("test")
    private let banners: [String] = ["homebanner1",
                                     "homebanner2",
                                     "homebanner3",
                                     "homebanner4",
                                     "homebanner5",
                                     "homebanner6",
                                     "homebanner7",
                                     "homebanner1"]
    
    weak var delegate: FooterScrollDelegate?
    
    private var item: Int = 0 {
        didSet {
            self.delegate?.didScrollTo(item)
        }
    }
    
    private var currentIndex: Int = 0
    private lazy var homeCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: configureCompositionalLayout())
        return cv
    }()
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            let info = section % 2
            switch info {
            case 0:
                return self.configureBannerSection()
            case 1:
                return self.configureItemListSection()
            default:
                return self.configureItemListSection()
            }
        }
    }
    
    private func configureBannerSection() -> NSCollectionLayoutSection {
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
    
    private func configureItemListSection() -> NSCollectionLayoutSection {
        
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
    
    private func configureNavigation() {
        let alertBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(alertBarButtonItemTapped))
        navigationItem.setRightBarButton(alertBarButtonItem, animated: false)

        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .systemGray
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @objc
    private func alertBarButtonItemTapped() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print("알림버튼 클릭")
        }
    }
    
    // MARK: - Action handlers
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        homeCollectionView.register(PageControlFooterView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                    withReuseIdentifier: PageControlFooterView.reuseIdentifier)
    }
}

extension HomeViewController {
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    func bannerMove() {
        currentIndex += 1
        homeCollectionView.scrollToItem(at: NSIndexPath(item: currentIndex, section: 0) as IndexPath, at: .bottom, animated: true)
        
        if self.currentIndex == self.banners.count-1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                self.scrollTofirstIndex()
            }
        }
    }
    
    func scrollTofirstIndex() {
        homeCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: false)
        currentIndex = 0
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
        configureCollectionView()
        configureNavigation()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section % 2 == 1 {
            guard let baseURL = URL(string: "http://ec2-3-35-137-187.ap-northeast-2.compute.amazonaws.com:8081")
            else { return }
            
            let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
            let networkService: NetworkService = DefaultNetworkService(config: config)
            let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
            let repository: ProductRepositoryInterface = ProductRepository(dataTransferService: dataTransferService)
            let usecase: ProductUseCaseInterface = ProductUseCase(repository)
            let viewModel: ProductViewModel = DefaultProductViewModel(usecase: usecase)
            let productViewController = ProductViewController(viewModel)
            productViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return banners.count
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
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier,
                                                                               for: indexPath) as? HomeViewCategoryHeaderView else
            { return UICollectionReusableView() }
            header.configure("\(Int.random(in: 0...100))")
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PageControlFooterView.reuseIdentifier,
                                                                               for: indexPath) as? PageControlFooterView else
            { return UICollectionReusableView() }
            
            self.delegate = footer
            footer.configure(banners.count)
            
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

