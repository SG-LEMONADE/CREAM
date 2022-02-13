//
//  ProductViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import UIKit

protocol FooterScrollDelegate: AnyObject {
    func didScrollTo(_ page: Int)
}

class ProductViewController: DIViewController<ProductViewModelInterface> {
    // MARK: Properties
    weak var delegate: FooterScrollDelegate?
    
    private var item: Int = 0 {
        didSet {
            self.delegate?.didScrollTo(item)
        }
    }
    
    private lazy var productView = ProductView()
    
    
    // MARK: View Life Cycle
    override func loadView() {
        self.view = productView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        configureUserEvent()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    func configureDelegate() {
        productView.ItemInfoListView.delegate = self
        productView.ItemInfoListView.dataSource = self
        productView.delegate = self
    }
    
    func bindViewModel() {
        viewModel.item.bind { [weak self] product in
            self?.productView.ItemInfoListView.reloadData()
            // TODO: button Info Setting
            self?.productView.tradeContainerView.sellButton.setPrice(product.highestBid)
            self?.productView.tradeContainerView.buyButton.setPrice(product.lowestAsk)
            self?.productView.tradeContainerView.wishButton.configure(product.wishCount)
        }
    }
}

extension ProductViewController: TradeDelegate {
    func moveFocusToProcessScene() {
        let processViewController = ProcessViewController(ProcessViewModel())
        let navigationController = UINavigationController(rootViewController: processViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension ProductViewController: BannerViewDelegate {
    func didReceivePageNumber(_ page: Int) {
        if page != self.item {
            self.item = page
        }
    }
}

// MARK: User Event
extension ProductViewController {
    func configureUserEvent() {
        self.productView.tradeContainerView.wishButton.addTarget(self, action: #selector(didTapWishButton), for: .touchUpInside)
        self.productView.tradeContainerView.buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        self.productView.tradeContainerView.sellButton.addTarget(self, action: #selector(didTapSellButton), for: .touchUpInside)
    }
    
    @objc
    func didTapWishButton() {
        print(#function)
    }
    
    @objc
    func didTapBuyButton() {
        let tradeViewController = TradeViewController(TradeViewModel(tradeType: .buy,
                                                                            viewModel.item.value))
        let navigationController = UINavigationController(rootViewController: tradeViewController)
        tradeViewController.delegate = self
        self.present(navigationController, animated: true)
    }
    
    @objc
    func didTapSellButton() {
        let tradeViewController = TradeViewController(TradeViewModel(tradeType: .sell,
                                                                            viewModel.item.value))
        let navigationController = UINavigationController(rootViewController: tradeViewController)
        self.present(navigationController, animated: true)
    }
}

extension ProductViewController: UICollectionViewDelegate {
    
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomeViewCategoryHeaderView.reuseIdentifier,
                                                                                   for: indexPath) as? HomeViewCategoryHeaderView
            else { return UICollectionReusableView() }
            
            header.configure(brandInfo: viewModel.item.value.brandName)
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: PageControlFooterView.reuseIdentifier,
                                                                               for: indexPath) as? PageControlFooterView
            else { return UICollectionReusableView() }
            
            self.delegate = footer
            footer.configure(viewModel.numberOfImageUrls)
            return footer
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = ProductView.SectionList(rawValue: section)
        else { return .zero }
        
        switch section {
        case .image:
            return viewModel.numberOfImageUrls
        case .itemInfo, .advertise, .delivery, .priceChart:
            return 1
        case .release:
            return viewModel.releaseInfo.count
        case .similarity:
            return viewModel.item.value.relatedProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = ProductView.SectionList(rawValue: indexPath.section)
        else { return UICollectionViewCell() }
        
        switch section {
        case .image:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            print(viewModel.item.value.backgroundColor)
            cell.backgroundColor = UIColor(rgb: viewModel.item.value.backgroundColor.hexToInt!)
            cell.configure(viewModel.item.value.imageUrls[indexPath.item])
            
            return cell
            
        case .itemInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.reuseIdentifier,
                                                                for: indexPath) as? ItemInfoCell
            else { return UICollectionViewCell() }
            cell.configure(viewModel.item.value)
            cell.delegate = self
            return cell
            
        case .release:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleaseInfoCell.reuseIdentifier, for: indexPath) as? ReleaseInfoCell
            else { return UICollectionViewCell() }
            cell.configure(with: viewModel.releaseInfo[indexPath.item])
           return cell
            
        case .delivery:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            
            cell.configureAds("banner_delivery", contentMode: .scaleAspectFit)
            return cell
            
        case .advertise:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            
            cell.configureAds("banner\(Int.random(in: 1...5))")
            return cell
            
        case .priceChart:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            
            return cell
            
        case .similarity:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reuseIdentifier,
                                                                for: indexPath) as? HomeProductCell
            else { return UICollectionViewCell() }
            
            cell.configure(viewModel.item.value.relatedProducts[indexPath.item], isRelatedItem: true)
            return cell
        }
    }
}

extension ProductViewController: ItemInfoCellDelegate {
    // TODO: Button Tap 이후, 상품에 해당하는 사이즈 가져오기
    func didTapSizeButton() {
        let sizeListViewController = SizeListViewController(SizeListViewModel(viewModel.item.value.sizes))
        sizeListViewController.modalPresentationStyle = .overCurrentContext
        self.present(sizeListViewController, animated: false)
    }
}
