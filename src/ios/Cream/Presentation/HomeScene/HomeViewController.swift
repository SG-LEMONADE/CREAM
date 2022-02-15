//
//  HomeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit

class HomeViewController: DIViewController<HomeViewModelInterface> {
    weak var delegate: FooterScrollDelegate?
    
    private lazy var homeView = HomeView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBarItem()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupNavigationBarItem() {
        let alertBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(alertBarButtonItemTapped))
        navigationItem.setRightBarButton(alertBarButtonItem, animated: false)
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupCollectionView() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
        homeView.delegate = self
        registerCollectionViewCell()
    }
    
    private func bindViewModel() {
        viewModel.homeInfo.bind { [weak self] _ in
            self?.homeView.homeCollectionView.reloadData()
        }
    }
    
    private func registerCollectionViewCell() {
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
    
    @objc
    private func alertBarButtonItemTapped() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print(#function)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section % 2 == 1 {
            guard let baseURL = URL(string: "http://1.231.16.189:8081")
            else { return }
            
            let config: NetworkConfigurable                 = ApiDataNetworkConfig(baseURL: baseURL)
            let networkService: NetworkService              = DefaultNetworkService(config: config)
            let dataTransferService: DataTransferService    = DefaultDataTransferService(with: networkService)
            let repository: ProductRepositoryInterface      = ProductRepository(dataTransferService: dataTransferService)
            let usecase: ProductUseCaseInterface            = ProductUseCase(repository)
            let viewModel: ProductViewModelInterface        = ProductViewModel(usecase: usecase,
                                                                               id: viewModel.homeInfo.value.sections[indexPath.section/2]
                                                                                .products[indexPath.item].id)
            let productViewController                       = ProductViewController(viewModel)
            
            productViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.homeInfo.value.ads.count
        }
        
        if section % 2 == 1 {
            return viewModel.homeInfo.value.sections[section/2].products.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell else
                                                                { return UICollectionViewCell() }
            cell.configure(viewModel.homeInfo.value.ads[indexPath.item])
            return cell
        } else if indexPath.section % 2 == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell else
                                                                { return UICollectionViewCell() }
            cell.configure(viewModel.homeInfo.value.sections[indexPath.section/2].imageUrl)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reuseIdentifier,
                                                                for: indexPath) as? HomeProductCell else
                                                                { return UICollectionViewCell() }
            cell.configure(viewModel.homeInfo.value.sections[indexPath.section/2].products[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier,
                                                                               for: indexPath) as? HomeViewCategoryHeaderView else
            { return UICollectionReusableView() }
            
            header.configure(headerInfo: viewModel.homeInfo.value.sections[indexPath.section/2].header,
                             detailInfo: viewModel.homeInfo.value.sections[indexPath.section/2].detail)
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PageControlFooterView.reuseIdentifier,
                                                                               for: indexPath) as? PageControlFooterView else
            { return UICollectionReusableView() }
            
            self.delegate = footer
            footer.configure(viewModel.homeInfo.value.ads.count)
            
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension HomeViewController: FooterScrollDelegate {
    func didScrollTo(_ page: Int) {
        delegate?.didScrollTo(page)
    }
}
