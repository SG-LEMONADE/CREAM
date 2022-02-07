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

class ProductViewController: BaseDIViewController<ProductViewModel> {
    // MARK: Properties
    weak var delegate: FooterScrollDelegate?
    
    private var item: Int = 0 {
        didSet {
            self.delegate?.didScrollTo(item)
        }
    }
    
    private lazy var productView = ProductView()
    
    // MARK: Init
    override init(_ viewModel: ProductViewModel) {
        super.init(viewModel)
    }
    
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
        let processViewController = ProcessViewController(DefaultProcessViewModel())
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
        let tradeViewController = TradeViewController(DefaultTradeViewModel(tradeType: .buy,
                                                                            viewModel.item.value))
        let navigationController = UINavigationController(rootViewController: tradeViewController)
        tradeViewController.delegate = self
        self.present(navigationController, animated: true)
    }
    
    @objc
    func didTapSellButton() {
        let tradeViewController = TradeViewController(DefaultTradeViewModel(tradeType: .sell,
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
            
            footer.configure(viewModel.count)
            
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
            return viewModel.count
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
            print(viewModel.item.value.backgroundColor)
            cell.backgroundColor = UIColor(rgb: viewModel.item.value.backgroundColor.hexToInt!)
            cell.configure(viewModel.item.value.imageUrls[indexPath.item])
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.reuseIdentifier,
                                                                for: indexPath) as? ItemInfoCell
            else { return UICollectionViewCell() }
            cell.configure(viewModel.item.value)
            cell.delegate = self
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleaseInfoCell.reuseIdentifier, for: indexPath) as? ReleaseInfoCell
            else { return UICollectionViewCell() }
            cell.configure(with: viewModel.releaseInfo[indexPath.item])
           return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .red
            cell.configureAds("banner_delivery")
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopBannerCell.reuseIdentifier,
                                                                for: indexPath) as? ShopBannerCell
            else { return UICollectionViewCell() }
            cell.backgroundColor = .blue
            cell.configureAds("banner\(Int.random(in: 1...5))")
            return cell
            
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reuseIdentifier,
                                                                for: indexPath) as? HomeProductCell
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

extension ProductViewController: ItemInfoCellDelegate {
    // TODO: Button Tap 이후, 상품에 해당하는 사이즈 가져오기
    func didTapSizeButton() {
        let sizeListViewController = SizeListViewController(DefaultSizeListViewModel(viewModel.item.value.sizes))
        sizeListViewController.modalPresentationStyle = .overCurrentContext
        self.present(sizeListViewController, animated: false)
    }
}
