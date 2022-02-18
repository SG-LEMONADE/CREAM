//
//  FinishViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/18.
//

import UIKit

class FinishViewController: DIViewController<ProcessViewModelInterface>, ImageLoadable {
    
    var session: URLSessionDataTask?
    
    var callbackClosure: (() -> Void)?
    
    private lazy var finishView = FinishView()
    
    override func loadView() {
        self.view = finishView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureView() 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        callbackClosure?()
    }
    
    private func setupNavigationBar() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseButton))
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItem = navigationItem
    }
    
    @objc
    func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureView() {
        if let _ = viewModel.validateDay.value {
            finishView.titleLabel.text = viewModel.tradeType.bidMessage
            finishView.descriptionLabel.text = viewModel.tradeType.bidDescription
        } else {
            finishView.titleLabel.text = viewModel.tradeType.completeMessage
            finishView.descriptionLabel.text = viewModel.tradeType.completeDescription
        }
        
        finishView.priceLabel.text = viewModel.tradeType.bottomDescription
        finishView.priceValueLabel.textColor = viewModel.tradeType.color
        
        finishView.deliveryValueLabel.text = viewModel.deliveryPrice.priceFormat + "원"
        finishView.priceValueLabel.text = (viewModel.requestPrice.value + viewModel.deliveryPrice).priceFormat + "원"
        finishView.itemPriceValueLabel.text = viewModel.requestPrice.value.priceFormat + "원"
        viewModel.product.backgroundColor.hexToInt.flatMap { 
            finishView.modelImageView.backgroundColor = UIColor(rgb: $0)
        }
        
        guard let urlString = viewModel.product.imageUrls.first,
              let url = URL(string: urlString)
        else {
            // TODO: url error의 경우, default Image load
            return
        }
        
        if let image = imageCache.image(forKey: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.finishView.modelImageView.image = image
            }
        } else {
            session = loadImage(url: url) { (image) in
                image.flatMap { imageCache.add($0, forKey: urlString) }
                DispatchQueue.main.async { [weak self] in
                    self?.finishView.modelImageView.image = image
                }
            }
        }
    }
}
