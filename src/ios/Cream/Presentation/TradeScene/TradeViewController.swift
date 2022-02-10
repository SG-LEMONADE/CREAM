//
//  TradeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/23.
//

import UIKit
import SnapKit

protocol TradeDelegate: AnyObject {    
    func moveFocusToProcessScene()
}

class TradeViewController: BaseDIViewController<TradeViewModel>, ImageLoadable {

    // MARK: Property
    var session: URLSessionDataTask?
    weak var delegate: TradeDelegate?
    
    private lazy var tradeView = TradeView()
    
    override init(_ viewModel: TradeViewModel) {
        super.init(viewModel)
    }
    
    // MARK: View Life Cycle
    override func loadView() {
        self.view = tradeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tradeView.sizeListView.register(SizeListCell.self, forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        setupNavigationBarItem()
        bindViewModel()
        configure()
    }
    
    func viewConfigure() {
        tradeView.sizeListView.dataSource = self
        tradeView.sizeListView.delegate = self
    }
    
    private func setupNavigationBarItem() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = navigationItem
    }
    
    func bindViewModel() {
        viewModel.selectSize.bind { [weak self] size, price in
            self?.tradeView.tradeButton.configure(size: size, priceText: price)
            self?.tradeView.tradeButton.isHidden = false
        }
    }    
    
    func configure() {
        viewConfigure()
        self.tradeView.itemNumberLabel.text = viewModel.product.styleCode
        self.tradeView.itemTitleLabel.text = viewModel.product.originalName
        self.tradeView.itemTranslatedLabel.text = viewModel.product.translatedName
        self.navigationItem.titleView = tradeView.navigationTitleView
        tradeView.topTitleLabel.text = viewModel.tradeType.navigationTitle
        self.navigationController?.navigationBar.tintColor = .black
        self.tradeView.tradeButton.addTarget(self, action: #selector(didTapTradeButton), for: .touchUpInside)
        
        guard let urlString = viewModel.product.imageUrls.first,
              let url = URL(string: urlString)
        else {
            // TODO: url error의 경우, default Image load
            return
        }
        
        session = loadImage(url: url, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.tradeView.modelImageView.image = image
            }
        })
    }
}

// MARK: User Event
extension TradeViewController {
    @objc
    func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapTradeButton() {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.moveFocusToProcessScene()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier, for: indexPath) as? SizeListCell else { return UICollectionViewCell() }
        
        cell.configure(size: viewModel.product.sizes[indexPath.item],
                       price: viewModel.product.askPrices[viewModel.product.sizes[indexPath.item]])
        
        return cell
    }
}

extension TradeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapSizeCell(indexPath: indexPath)
    }
}
