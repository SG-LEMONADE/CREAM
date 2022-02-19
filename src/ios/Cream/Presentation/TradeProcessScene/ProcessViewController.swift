//
//  ProcessViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/03.
//

import UIKit
import Toast_Swift

class ProcessViewController: DIViewController<ProcessViewModelInterface>, ImageLoadable {
    
    // MARK: Property
    var session: URLSessionDataTask?
    
    var callbackClosure: (() -> Void)?
    
    private lazy var processView = ProcessView()
    
    override func loadView() {
        self.view = processView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInputTextField()
        setupSegmentControl()
        setupUserAction()
        configureView()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        callbackClosure?()
    }
    
    private func setupNavigationBar() {
        processView.cancelButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        processView.inspectionButton.addTarget(self, action: #selector(didTapInspectButton), for: .touchUpInside)
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: processView.cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: processView.inspectionButton)
    }
    
    private func setupSegmentControl() {
        let tradeType = viewModel.tradeType
        processView.segmentControl.setTitle("\(tradeType.description) 입찰", forSegmentAt: 0)
        processView.segmentControl.setTitle("즉시 \(tradeType.description)", forSegmentAt: 1)
        processView.segmentControl.selectedSegmentTintColor = tradeType.color
        processView.segmentControl.addTarget(self,
                                             action: #selector(segmentedControlValueChanged(_:)),
                                             for: .valueChanged)
    }
    
    private func setupInputTextField() {
        processView.priceTextField.textField.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.tradeAvailable.bind { [weak self] isInvalid in
            self?.processView.segmentControl.setEnabled(!isInvalid, forSegmentAt: 1)
            self?.processView.validateView.isHidden = !isInvalid
//            if isAvailable {
//                self?.processView.segmentControl.setEnabled(false, forSegmentAt: 1)
//                self?.processView.validateView.isHidden = false
//            } else {
//                self?.processView.validateView.isHidden = true
//            }
        }
        
        viewModel.requestPrice.bind { [weak self] price in
            if price > 0 {
                self?.processView.tradeBottomBar.totalLabel.priceLabel.text =  (price+(self?.viewModel.deliveryPrice)!).priceFormatWithUnit
                self?.processView.priceTextField.textField.text = price.priceFormat
            } else {
                self?.processView.tradeBottomBar.totalLabel.priceLabel.text = "-"
                self?.processView.priceTextField.textField.text = nil
            }
        }
        
        viewModel.validateDay.bind { [weak self] date in
            if let date = date {
                self?.processView.validateView.dateValueLabel.text = date.caculateDeadLine()
            } else {
                self?.processView.validateView.dateValueLabel.text = nil
            }
        }
        
        viewModel.tradeResult.bind { [weak self] isSuccess in
            if isSuccess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
                    self?.processView.activityIndicator.stopAnimating()
                    guard let viewModel = self?.viewModel
                    else { return }
                    
                    let vc = FinishViewController(viewModel)
                    vc.callbackClosure = self?.callbackClosure
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
                    self?.processView.activityIndicator.stopAnimating()
                    self?.view.makeToast("거래에 실패했습니다.",
                                         duration: 1.5,
                                         position: .center)
                }
            }
        }
    }

    
    private func configureView() {
        processView.productInfoView.itemNumberLabel.text            = viewModel.product.styleCode
        processView.productInfoView.itemTitleLabel.text             = viewModel.product.originalName
        processView.productInfoView.itemTranslatedLabel.text        = viewModel.product.translatedName
        processView.productInfoView.sizeLabel.text                  = viewModel.selectedProduct.size
        processView.tradeBottomBar.totalLabel.tradeTypeLabel.text   = viewModel.tradeType.bottomDescription
        processView.deliveryValueLabel.text                         = viewModel.deliveryInfo
        
        viewModel.validateDay.value.flatMap {
            processView.validateView.dateValueLabel.text = $0.caculateDeadLine()
        }

        if let price = viewModel.selectedProduct.price {
            processView.segmentControl.selectedSegmentIndex = .one
            processView.validateView.isHidden = true
            processView.priceTextField.textField.text = price.priceFormat
            processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.instantTradeTitle,
                                                            for: .normal)
            processView.tradeBottomBar.totalLabel.priceLabel.text = "\((price+viewModel.deliveryPrice).priceFormat) 원"
        } else {
            processView.segmentControl.selectedSegmentIndex = .zero
            processView.validateView.isHidden = false
            processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.waitingTradeTitle,
                                                            for: .normal)
            processView.tradeBottomBar.totalLabel.priceLabel.text = "-"
        }
        
        if let askPrice = viewModel.product.askPrices[viewModel.selectedProduct.size] {
            askPrice.flatMap {
                processView.buyLabel.priceLabel.text = $0.priceFormatWithUnit
            }
        } else {
            processView.buyLabel.priceLabel.text = "-"
        }
        
        if let bidPrice = viewModel.product.bidPrices[viewModel.selectedProduct.size] {
            bidPrice.flatMap {
                processView.sellLabel.priceLabel.text = $0.priceFormatWithUnit
            }
        } else {
            processView.sellLabel.priceLabel.text = "-"
        }
        
        viewModel.product.backgroundColor.hexToInt.flatMap {
            processView.productInfoView.modelImageView.backgroundColor = UIColor(rgb: $0)
        }
        
        guard let urlString = viewModel.product.imageUrls.first,
              let url = URL(string: urlString)
        else {
            return
        }
        
        if let image = imageCache.image(forKey: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.processView.productInfoView.modelImageView.image = image
            }
        } else {
            session = loadImage(url: url) { (image) in
                image.flatMap { imageCache.add($0, forKey: urlString) }
                DispatchQueue.main.async { [weak self] in
                    self?.processView.productInfoView.modelImageView.image = image
                }
            }
        }
    }
    
    private func setupUserAction() {
        processView.tradeBottomBar.tradeButton.addTarget(self,
                                                         action: #selector(didTapTradeButton),
                                                         for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapValidateView))
        processView.validateView.addGestureRecognizer(tapGesture)
    }
    
    private func addBorder(thickness: CGFloat = 0.5,
                           color: UIColor = .systemGray3) {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0,
                                 width: processView.tradeBottomBar.frame.size.width,
                                 height: thickness)
        topBorder.backgroundColor = color.cgColor
        processView.tradeBottomBar.layer.addSublayer(topBorder)
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == .zero {
            processView.priceTextField.textField.text = nil
            processView.descriptionLabel.text = "\(viewModel.tradeType.description) 희망가"
            processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.waitingTradeTitle,
                                                            for: .normal)
            
            processView.tradeBottomBar.totalLabel.priceLabel.text = "- 원"
        
            processView.validateView.isHidden = false
        } else {
            processView.priceTextField.textField.text = viewModel.selectedProduct.price?.priceFormat
            processView.descriptionLabel.text = "즉시 \(viewModel.tradeType.description)가"
            processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.instantTradeTitle,
                                                            for: .normal)
            if let price = viewModel.selectedProduct.price {
                processView.tradeBottomBar.totalLabel.priceLabel.text = "\((price+viewModel.deliveryPrice).priceFormat) 원"
            }
            processView.validateView.isHidden = true
        }
    }
    
    @objc
    func didTapValidateView() {
        let items = viewModel.deadLines.map { SelectionType.deadline(date: $0) }
        
        let viewModel = SelectViewModel(type: .deadline(), items: items)
        let viewController = SelectViewController(viewModel)
        viewController.delegate = self
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: false, completion: nil)
    }
    
    @objc
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: 미구현 예정
    @objc
    func didTapInspectButton() {
        print(#function)
    }
    
    @objc
    func didTapTradeButton() {
        processView.activityIndicator.startAnimating()
        viewModel.didTapTradeButton()
    }
}

extension ProcessViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        processView.priceTextField.textField.text = nil
        processView.segmentControl.selectedSegmentIndex = .zero
        processView.validateView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let priceString = textField.text,
              let price = Int(priceString)
        else {
            viewModel.requestPrice.value = .zero
            return
        }
        
        switch viewModel.tradeType {
        case .buy:
            if let askPrice = viewModel.selectedProduct.price {
                if price < askPrice {
                    viewModel.requestPrice.value = price
                    processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.waitingTradeTitle,
                                                                    for: .normal)
                } else {
                    processView.segmentControl.selectedSegmentIndex = .one
                    processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.instantTradeTitle,
                                                                    for: .normal)
                    viewModel.requestPrice.value = askPrice
                }
            } else {
                viewModel.requestPrice.value = price
            }
        case .sell:
            if let bidPrice = viewModel.selectedProduct.price {
                if price > bidPrice {
                    viewModel.requestPrice.value = price
                    processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.waitingTradeTitle,
                                                                    for: .normal)
                } else {
                    processView.segmentControl.selectedSegmentIndex = .one
                    processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.instantTradeTitle,
                                                                    for: .normal)
                    viewModel.requestPrice.value = bidPrice
                }
            } else {
                viewModel.requestPrice.value = price
            }
        }
    }
}

extension ProcessViewController: SelectDelegate {
    func didTapDeadline(_ deadline: Int) {
        viewModel.didSelectDeadline(deadline)
    }
}
