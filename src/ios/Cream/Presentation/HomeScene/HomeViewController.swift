//
//  HomeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit

class HomeListViewController: BaseDIViewController<HomeViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: FooterScrollDelegate {
    func didScrollTo(_ page: Int) {
        delegate?.didScrollTo(page)
    }
}

class HomeViewController: UIViewController {
    
    weak var delegate: FooterScrollDelegate?
    
    private let viewModel = HomeViewModel.init("test")
    private let banners: [String] = ["homebanner1",
                                     "homebanner2",
                                     "homebanner3",
                                     "homebanner4",
                                     "homebanner5",
                                     "homebanner6",
                                     "homebanner7",
                                     "homebanner1"]
    
    
    private lazy var homeView = HomeView()
    private var currentIndex: Int = 0
    
//    var item: Int = 0 {
//        didSet {
//            self.delegate?.didScrollTo(item)
//        }
//    }
    
    
    private func configureNavigation() {
        self.navigationController?.navigationBar.tintColor = .black
        let alertBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(alertBarButtonItemTapped))
        navigationItem.setRightBarButton(alertBarButtonItem, animated: false)
    }
    
    @objc
    private func alertBarButtonItemTapped() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print(#function)
        }
    }
    // MARK: - Action handlers
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        configureCollectionView()
        configureNavigation()
    }
    
    private func configureDelegate() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
        homeView.delegate = self
    }
    
    func configureCollectionView() {
        homeView.homeCollectionView.register(ShopBannerCell.self,
                                    forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
        homeView.homeCollectionView.register(SizeListCell.self,
                                    forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        homeView.homeCollectionView.register(HomeProductCell.self,
                                    forCellWithReuseIdentifier: HomeProductCell.reuseIdentifier)
        homeView.homeCollectionView.register(HomeViewCategoryHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier)
        homeView.homeCollectionView.register(PageControlFooterView.self,
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
        homeView.homeCollectionView.scrollToItem(at: NSIndexPath(item: currentIndex, section: 0) as IndexPath, at: .bottom, animated: true)

        if self.currentIndex == self.banners.count-1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                self.scrollTofirstIndex()
            }
        }
    }

    func scrollTofirstIndex() {
        homeView.homeCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: false)
        currentIndex = 0
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section % 2 == 1 {
            guard let baseURL = URL(string: "http://ec2-3-36-85-82.ap-northeast-2.compute.amazonaws.com:8081")
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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reuseIdentifier,
                                                            for: indexPath) as? HomeProductCell else
                                                            { return UICollectionViewCell() }
        cell.configureTest()
        
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

