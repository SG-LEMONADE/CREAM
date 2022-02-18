//
//  TradeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/23.
//

import UIKit
import SnapKit

protocol TradeDelegate: AnyObject {    
    func moveFocusToProcessScene(selectedProduct: TradeRequest, tradeType: TradeType)
}

class TradeViewController: DIViewController<TradeViewModelInterface>, ImageLoadable {
    
    // MARK: Property
    var session: URLSessionDataTask?
    weak var delegate: TradeDelegate?
    
    private lazy var tradeView = TradeView()
    
    // MARK: View Life Cycle
    override func loadView() {
        self.view = tradeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tradeView.sizeListView.register(SizePriceCell.self, forCellWithReuseIdentifier: SizePriceCell.reuseIdentifier)
        setupNavigationBar()
        bindViewModel()
        configure()
    }
    
    func viewConfigure() {
        tradeView.sizeListView.dataSource = self
        tradeView.sizeListView.delegate = self
    }
    
    private func setupNavigationBar() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = navigationItem
    }
    
    func bindViewModel() {
        viewModel.selectSize.bind { [weak self] request in
            guard let tradeType = self?.viewModel.tradeType
            else { return }
            
            self?.tradeView.tradeButton.isHidden = false
            
            self?.tradeView.tradeButton.configure(price: request.price,
                                                  type: tradeType)
        }
    }
    
    func configure() {
        viewConfigure()
        tradeView.itemNumberLabel.text = viewModel.product.styleCode
        tradeView.itemTitleLabel.text = viewModel.product.originalName
        tradeView.itemTranslatedLabel.text = viewModel.product.translatedName
        tradeView.tradeButton.addTarget(self, action: #selector(didTapTradeButton), for: .touchUpInside)
        
        tradeView.topTitleLabel.text = viewModel.tradeType.navigationTitle
        navigationItem.titleView = tradeView.navigationTitleView
        navigationController?.navigationBar.tintColor = .black
        
        viewModel.product.backgroundColor.hexToInt.flatMap {
            tradeView.modelImageView.backgroundColor = UIColor(rgb: $0)
        }
        
        guard let urlString = viewModel.product.imageUrls.first,
              let url = URL(string: urlString)
                
        else {
            // TODO: url error의 경우, default Image load
            return
        }
        
        if let image = imageCache.image(forKey: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.tradeView.modelImageView.image = image
            }
        } else {
            session = loadImage(url: url) { (image) in
                image.flatMap { imageCache.add($0, forKey: urlString) }
                DispatchQueue.main.async { [weak self] in
                    self?.tradeView.modelImageView.image = image
                }
            }
        }
    }
}

// MARK: User Event
extension TradeViewController {
    @objc
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapTradeButton() {
        dismiss(animated: true) { [weak self] in
            guard let self = self
            else { return }

            self.delegate?.moveFocusToProcessScene(selectedProduct: self.viewModel.selectSize.value,
                                                   tradeType: self.viewModel.tradeType)
        }
    }
}

// MARK: CollectionView Layout & CollectionView Cell Configuration
extension TradeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellLayout = CGSize(width: (collectionView.bounds.size.width - viewModel.numberOfColumns * TradeView.Constraint.GridWidthSpacing) / viewModel.numberOfColumns, height: ((collectionView.bounds.size.width - TradeView.Constraint.GridHeightSpacing) / 2) * 0.25)
        return cellLayout
    }
}

extension TradeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizePriceCell.reuseIdentifier, for: indexPath) as? SizePriceCell
        else { return UICollectionViewCell() }
        
        switch viewModel.tradeType {
        case .buy:
            cell.configure(size: viewModel.product.sizes[indexPath.item],
                           price: viewModel.product.askPrices[viewModel.product.sizes[indexPath.item]]!,
                           type: viewModel.tradeType)
        case .sell:
            cell.configure(size: viewModel.product.sizes[indexPath.item],
                           price: viewModel.product.bidPrices[viewModel.product.sizes[indexPath.item]]!,
                           type: viewModel.tradeType)
        }
        return cell
    }
}

extension TradeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapSizeCell(indexPath: indexPath)
    }
}
