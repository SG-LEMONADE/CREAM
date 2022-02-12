//
//  ProductListViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import UIKit
import SnapKit

protocol SortChangeDelegate: AnyObject {
    func didChangeStandard(to standard: String)
}

extension ProductListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _ = viewModel.viewDidLoad()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        _ = viewModel.didSearch(with: text)
    }
}

class ProductListViewController: BaseDIViewController<ProductListViewModel> {
    
    enum Constraint {
        static let verticalInset: CGFloat = 20
        static let horizontalInset: CGFloat = 20
    }
    private var currentBanner: Int = 0
    private var selectedIndexPaths = [IndexPath]()
    private lazy var productListView = ProductListView()
        
    weak var delegate: SortChangeDelegate?
    override init(_ viewModel: ProductListViewModel) {
        super.init(viewModel)
    }
    
    // MARK: View Life Cycle
    override func loadView() {
        self.view = productListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .clear
        setupCollectionView()
        setupSearchController()
        bindViewModel()
        productListView.indicatorView.startAnimating()
        viewModel.viewDidLoad()
        viewConfigure()
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "브랜드명, 모델명, 모델번호 등"
        searchController.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = .black
        
        self.navigationItem.searchController = searchController
        
        self.definesPresentationContext = true
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "cream_loco")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    private func setupCollectionView() {
        productListView.shopCollectionView.dataSource = self
        productListView.shopCollectionView.delegate = self
        
        productListView.shopCollectionView.register(ShopBannerCell.self,
                                    forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
        productListView.shopCollectionView.register(SizeListCell.self,
                                    forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        productListView.shopCollectionView.register(ProductListItemCell.self,
                                    forCellWithReuseIdentifier: ProductListItemCell.reuseIdentifier)
        productListView.shopCollectionView.register(ShopViewFilterHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: ShopViewFilterHeaderView.reuseIdentifier)
        productListView.shopCollectionView.register(SortFilterFooterView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                    withReuseIdentifier: SortFilterFooterView.reuseIdentifier)
    }
    
    func viewConfigure() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .systemGray
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func bindViewModel() {
        self.viewModel.products.bind { [weak self] _ in
            DispatchQueue.main.async {
                guard let self = self
                else { return }
                
                self.productListView.shopCollectionView.reloadSections(.init(integer: 1))
                self.delegate?.didChangeStandard(to: self.viewModel.sortStandard.description)
                self.productListView.indicatorView.stopAnimating()
                
            }
        }
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.banners.count
        default:
            if (self.viewModel.products.value.count == 0) {
                productListView.shopCollectionView.setEmptyMessage("검색 결과가 없습니다.")
                productListView.shopCollectionView.isScrollEnabled = false
            } else {
                productListView.shopCollectionView.restore()
                productListView.shopCollectionView.isScrollEnabled = true
            }
            return viewModel.products.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.configureAds(viewModel.banners[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListItemCell.reuseIdentifier,
                                                                for: indexPath) as? ProductListItemCell
            else { return UICollectionViewCell() }
            
            cell.configure(viewModel.products.value[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: ShopViewFilterHeaderView.reuseIdentifier,
                                                                               for: indexPath) as? ShopViewFilterHeaderView
            else { return UICollectionReusableView() }
            
            header.delegate = self
            header.dataSource = self
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: SortFilterFooterView.reuseIdentifier,
                                                                               for: indexPath) as? SortFilterFooterView
            else { return UICollectionReusableView() }
            header.delegate = self
            self.delegate = header
            
            return header

        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let baseURL = URL(string: "http://1.231.16.189:8081")
            else { return }
        
            let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
            let networkService: NetworkService = DefaultNetworkService(config: config)
            let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
            let repository: ProductRepositoryInterface = ProductRepository(dataTransferService: dataTransferService)
            let usecase: ProductUseCaseInterface = ProductUseCase(repository)
            var viewModel: ProductViewModel = DefaultProductViewModel(usecase: usecase)
            viewModel.id = self.viewModel.products.value[indexPath.item].id 
            let productViewController = ProductViewController(viewModel)
            
            productViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

extension ProductListViewController: ShopViewFilterHeaderViewDelegate {
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
        if indexPath.item == .zero {
            // TODO: FilterUseCase 구성
            let filterViewModel: FilterViewModel = DefaultFilterViewModel(FilterUseCase())
            let filterViewController = FilterViewController(filterViewModel)
            let navigationController = UINavigationController(rootViewController: filterViewController)
            self.present(navigationController, animated: true)
            return
        }
        
        if indexPath.item > 2 {
            productListView.indicatorView.startAnimating()
            viewModel.didTapCategory(indexPath: indexPath)
        }
    }
    
    // MARK: CHECKLIST 색상 변경
    private func getAttachment(color: UIColor) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "checklist")
        attachment.image = attachment.image?.withTintColor(color)
        return NSAttributedString(attachment: attachment)
    }
}

extension ProductListViewController: ShopViewFilterHeaderViewDataSource {
    func setupNumberOfItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func setupCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifer, for: indexPath) as? FilterCell
        else { return UICollectionViewCell() }
        
        if indexPath.item == .zero {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(systemName: "checklist")
            let attachmentString = NSAttributedString(attachment: attachment)

            cell.titleLabel.attributedText = attachmentString
            cell.titleLabel.sizeToFit()
        } else {
            cell.configure(viewModel.categories[indexPath.item])
            cell.titleLabel.sizeToFit()
        }

        if indexPath.item == 2 {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
}

extension ProductListViewController: SortFilterFooterViewDelegate {
    func didTapSortButton() {
        let viewModel = DefaultSortViewModel()
        let sortViewController = SortViewController(viewModel)
        sortViewController.delegate = self
        
        sortViewController.modalPresentationStyle = .overFullScreen
        self.present(sortViewController, animated: false)
    }
}

extension ProductListViewController: SortSelectDelegate {
    func updateListData(_ standard: String) {
        viewModel.didSelectSortOrder(standard)
    }
}
