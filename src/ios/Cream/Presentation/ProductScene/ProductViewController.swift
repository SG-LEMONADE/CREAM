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
    var callbackClosure: (() -> Void)?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        addBorder()
    }
    
    func configureDelegate() {
        productView.ItemInfoListView.delegate = self
        productView.ItemInfoListView.dataSource = self
        productView.delegate = self
    }
    
    private func addBorder(thickness: CGFloat = 0.5, color: UIColor = .systemGray3) {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0,
                                 width: productView.tradeContainerView.frame.size.width,
                                 height: thickness)
        topBorder.backgroundColor = color.cgColor
        productView.tradeContainerView.layer.addSublayer(topBorder)
    }
    
    func bindViewModel() {
        viewModel.item.bind { [weak self] product in
            self?.productView.ItemInfoListView.reloadData()
            self?.productView.tradeContainerView.sellButton.setPrice(product.highestBid)
            self?.productView.tradeContainerView.buyButton.setPrice(product.lowestAsk)
            self?.productView.tradeContainerView.wishButton.configure(product)
        }
        
        viewModel.selecteSize.bind { [weak self] size in
            self?.productView.ItemInfoListView.reloadItems(at: [.init(item: 0, section: 1)])
            if let _askPrice = self?.viewModel.item.value.askPrices[size],
               let askPrice = _askPrice {
                self?.productView.tradeContainerView.buyButton.setPrice(askPrice)
            } else {
                self?.productView.tradeContainerView.buyButton.setPrice(nil)
            }
            if let _bidPrice =  self?.viewModel.item.value.bidPrices[size],
               let bidPrice = _bidPrice {
                self?.productView.tradeContainerView.sellButton.setPrice(bidPrice)
            } else {
                self?.productView.tradeContainerView.sellButton.setPrice(nil)
            }
        }
        
//        viewModel.priceChange.bind { [weak self] value in
//            self?.productView.ItemInfoListView.reloadItems(at: [.init(item: 0, section: 1)])
//        }
    }
}

// MARK: User Event
extension ProductViewController {
    func configureUserEvent() {
        productView.tradeContainerView.wishButton.addTarget(self, action: #selector(didTapWishButton), for: .touchUpInside)
        productView.tradeContainerView.buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        productView.tradeContainerView.sellButton.addTarget(self, action: #selector(didTapSellButton), for: .touchUpInside)
    }
    
    @objc
    func didTapBackButton() {
        callbackClosure?()
    }
    
    @objc
    func didTapWishButton() {
        var items: [SelectionType] = []
        
        let item = viewModel.item.value
        if let wishList = item.wishList {
            item.sizes.forEach {
                if wishList.contains($0) {
                    items.append(SelectionType.wish(size: $0, isSelected: true))
                } else {
                    items.append(SelectionType.wish(size: $0, isSelected: false))
                }
            }
        } else {
            items = item.sizes.map{ SelectionType.wish(size: $0, isSelected: false) }
        }
        
        let vm = SelectViewModel(type: .wish(), items: items)
        let vc = SelectViewController(vm)
        vc.selectCompleteHandler = { [weak self] in
            self?.viewModel.viewDidLoad()
        }
        vc.delegate = self
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }
    
    @objc
    func didTapBuyButton() {
        let tradeViewModel = TradeViewModel(tradeType: .buy,
                                            viewModel.item.value)
        let tradeViewController = TradeViewController(tradeViewModel)
        tradeViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: tradeViewController)
        
        present(navigationController, animated: true)
    }
    
    @objc
    func didTapSellButton() {
        let tradeViewModel = TradeViewModel(tradeType: .sell,
                                            viewModel.item.value)
        let tradeViewController = TradeViewController(tradeViewModel)
        tradeViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: tradeViewController)
        
        present(navigationController, animated: true)
    }
}

// MARK: UICollectionViewDataSource
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
            
            viewModel.item.value.backgroundColor.hexToInt.flatMap {
                cell.backgroundColor = UIColor(rgb: $0)
            }
            
            cell.configure(viewModel.item.value.imageUrls[indexPath.item])
            
            return cell
            
        case .itemInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.reuseIdentifier,
                                                                for: indexPath) as? ItemInfoCell
            else { return UICollectionViewCell() }
            cell.configure(viewModel.item.value, size: viewModel.selecteSize.value)
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCell.reuseIdentifier,
                                                                for: indexPath) as? ChartCell
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

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = ProductView.SectionList(rawValue: indexPath.section)
        else { return }
        
        if case .similarity = section {
            
            let product = viewModel.item.value.relatedProducts[indexPath.item]
            guard let baseURL = URL(string: Integrator.gateWayURL)
            else { return }
            
            let config: NetworkConfigurable              = ApiDataNetworkConfig(baseURL: baseURL)
            let networkService: NetworkService           = DefaultNetworkService(config: config)
            let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
            let repository: ProductRepositoryInterface   = ProductRepository(dataTransferService: dataTransferService)
            let usecase: ProductUseCaseInterface         = ProductUseCase(repository)
            let viewModel: ProductViewModelInterface     = ProductViewModel(usecase: usecase,
                                                                            id: product.id)
            let productViewController = ProductViewController(viewModel)
            
            productViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

extension ProductViewController: TradeDelegate {
    func moveFocusToProcessScene(selectedProduct: TradeRequest, tradeType: TradeType) {
        guard let baseURL = URL(string: Integrator.gateWayURL)
        else { fatalError() }
        
        let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService: NetworkService = DefaultNetworkService(config: config)
        let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
        let repository = ProductRepository(dataTransferService: dataTransferService)
        let usecase = TradeUseCase(repository)
        let vm = ProcessViewModel(usecase,
                                  tradeType: tradeType,
                                  product: viewModel.item.value,
                                  selectedProduct: selectedProduct)
        
        let vc = ProcessViewController(vm)
        vc.callbackClosure = { [weak self] in
            self?.viewModel.viewDidLoad()
        }
        let navigationController = UINavigationController(rootViewController: vc)
        
        let backBarButtonItem = UIBarButtonItem(title: nil,
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapBackButton))
        backBarButtonItem.tintColor = .systemGray
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true, completion: nil)
    }
}

extension ProductViewController: BannerViewDelegate {
    func didReceivePageNumber(_ page: Int) {
        if page != self.item {
            self.item = page
        }
    }
}

extension ProductViewController: ItemInfoCellDelegate {
    func didTapSizeButton() {
        //        .map { SelectionType.sizePrice(size: $0.key, price: $0.value) }
        let askPrices = viewModel.item.value.askPrices
        
        var items: [SelectionType] = []
        //      // TODO: refactor
        //      viewModel.didTapSizeButton()
        
        viewModel.item.value.sizes.forEach {
            if let _price = askPrices[$0] {
                if let price = _price {
                    items.append(SelectionType.sizePrice(size: $0, price: price))
                } else {
                    items.append(SelectionType.sizePrice(size: $0, price: nil))
                }
            } else {
                items.append(SelectionType.sizePrice(size: $0, price: nil))
            }
        }
        
        
        let vm = SelectViewModel(type: .sizePrice(), items: items)
        let vc = SelectViewController(vm)
        vc.delegate = self
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
}

extension ProductViewController: SelectDelegate {
    func didRemoveFromWishlist(_ size: String) {
        viewModel.removeFromWishList(size: size)
    }
    
    func didAppendToWishList(_ size: String) {
        viewModel.addToWishList(size: size)
    }
    
    func didSelectItem(_ size: String) {
        viewModel.didSelectItem(size: size)
    }
}
