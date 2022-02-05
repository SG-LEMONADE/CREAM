//
//  ProductListViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/31.
//

import UIKit
import SnapKit

class ProductListViewController: BaseDIViewController<ProductListViewModel> {

    private var currentBanner: Int = 0
    enum Constraint {
        static let verticalInset: CGFloat = 20
        static let horizontalInset: CGFloat = 20
    }
    
    private lazy var productListView = ProductListView()
    private var selectedIndexPaths = [IndexPath]()
    
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
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupCollectionView() {
        productListView.shopCollectionView.dataSource = self
        productListView.shopCollectionView.delegate = self
        
        productListView.shopCollectionView.register(ShopBannerCell.self,
                                    forCellWithReuseIdentifier: ShopBannerCell.reuseIdentifier)
        productListView.shopCollectionView.register(SizeListCell.self,
                                    forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        productListView.shopCollectionView.register(HomeViewItemCell.self,
                                    forCellWithReuseIdentifier: HomeViewItemCell.reuseIdentifier)
        productListView.shopCollectionView.register(ShopViewFilterHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: ShopViewFilterHeaderView.reuseIdentifier)
    }
    
    override func viewConfigure() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .systemGray
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func bindViewModel() {
        self.viewModel.products.bind { [weak self] _ in
            self?.productListView.shopCollectionView.reloadSections(.init(integer: 1))
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
            return viewModel.products.value.count
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
            
            cell.configure(viewModel.products.value[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: ShopViewFilterHeaderView.reuseIdentifier,
                                                                           for: indexPath) as? ShopViewFilterHeaderView
        else { return UICollectionReusableView() }
        
        header.delegate = self
        header.dataSource = self
        return header
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let baseURL = URL(string: "http://ec2-13-209-18-231.ap-northeast-2.compute.amazonaws.com:8081")
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
            let sizeListViewModel: SizeListViewModel = DefaultSizeListViewModel()
            let sizeListViewController = SizeListViewController(sizeListViewModel)
            self.present(sizeListViewController, animated: false)
            return
        }
        
        guard let filterCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? FilterCell,
              let selectedCell = collectionView.cellForItem(at: indexPath) as? FilterCell
        else { return }
        
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            selectedCell.titleLabel.textColor = .black
            selectedIndexPaths.remove(at: index)
        } else if (3 ..< viewModel.categories.count).contains(indexPath.item) {
//            selectedIndexPaths.forEach {
//                if $0.item > 2 {
//                    collectionView.deselectItem(at: $0, animated: true)
//                    selectedCell.titleLabel.textColor = .black
//                    selectedIndexPaths.firstIndex(of: $0).flatMap {
//                        selectedIndexPaths.remove(at: $0)
//                    }
//                    
//                }
//            }
            selectedIndexPaths.append(indexPath)
            selectedCell.titleLabel.textColor = .red
            
            viewModel.didTapCategory(indexPath: indexPath)
        }
        
        if selectedIndexPaths.isEmpty {
            filterCell.titleLabel.attributedText = getAttachment(color: .black)
        } else {
            filterCell.titleLabel.attributedText = getAttachment(color: .red)
        }
    }
    
    func didDeSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
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
