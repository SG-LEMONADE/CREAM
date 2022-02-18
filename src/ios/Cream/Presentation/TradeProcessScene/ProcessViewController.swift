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
        let cancelButton: UIButton = {
            let button = UIButton.init(type: .custom)
            button.setTitle("취소", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
            return button
        }()
        
        let inspectionButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("검수 기준", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.addTarget(self, action: #selector(didTapInspectButton), for: .touchUpInside)
            button.contentEdgeInsets = .init(top: 3, left: 10, bottom: 3, right: 10)
            return button
        }()
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: inspectionButton)
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
        viewModel.requestPrice.bind { [weak self] price in
            if price > 0 {
                self?.processView.tradeBottomBar.totalLabel.priceLabel.text =  "\((price+(self?.viewModel.deliveryPrice)!).priceFormat) 원"
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
                self?.dismiss(animated: true)
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.view.makeToast("거래에 실패했습니다.",
                                         duration: 1.5,
                                         position: .center)
                }
            }
        }
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
    
    private func configureView() {
        viewModel.validateDay.value.flatMap {
            processView.validateView.dateValueLabel.text = $0.caculateDeadLine()
        }
        processView.productInfoView.itemNumberLabel.text = viewModel.product.styleCode
        processView.productInfoView.itemTitleLabel.text = viewModel.product.originalName
        processView.productInfoView.itemTranslatedLabel.text = viewModel.product.translatedName
        processView.productInfoView.sizeLabel.text = viewModel.selectedProduct.size
        processView.tradeBottomBar.totalLabel.tradeTypeLabel.text = viewModel.tradeType.bottomDescription
        
        if viewModel.selectedProduct.price == nil {
            processView.segmentControl.setEnabled(false, forSegmentAt: 1)
            processView.validateView.isHidden = true
        }
        
        if viewModel.tradeType == .buy {
            processView.deliveryValueLabel.text = viewModel.deliveryPrice.priceFormat + "원"
        } else {
            processView.deliveryValueLabel.text = "선불﹒판매자 부담"
        }
        
        if let askPrice = viewModel.product.askPrices[viewModel.selectedProduct.size] {
            askPrice.flatMap {
                if viewModel.tradeType == .buy {
                    processView.segmentControl.selectedSegmentIndex = .one
                    processView.validateView.isHidden = true
                }
                processView.buyLabel.priceLabel.text = $0.priceFormat + "원"
                processView.priceTextField.textField.text = $0.priceFormat
            }
        } else {
            processView.buyLabel.priceLabel.text = "-"
        }
        
        if let bidPrice = viewModel.product.bidPrices[viewModel.selectedProduct.size] {
            bidPrice.flatMap {
                if viewModel.tradeType == .sell {
                    processView.segmentControl.selectedSegmentIndex = .one
                    processView.validateView.isHidden = true
                }
                processView.sellLabel.priceLabel.text = $0.priceFormat + "원"
                processView.priceTextField.textField.text = $0.priceFormat
            }
            processView.isUserInteractionEnabled = true
        } else {
            processView.sellLabel.priceLabel.text = "-"
        }
        
        if let price = viewModel.selectedProduct.price {
            processView.tradeBottomBar.totalLabel.priceLabel.text = "\((price+viewModel.deliveryPrice).priceFormat) 원"
        }
        
        viewModel.product.backgroundColor.hexToInt.flatMap {
            processView.productInfoView.modelImageView.backgroundColor = UIColor(rgb: $0)
        }
        
        guard let urlString = viewModel.product.imageUrls.first,
              let url = URL(string: urlString)
        else {
            // TODO: url error의 경우, default Image load
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
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == .zero {
            processView.priceTextField.textField.text = nil
            processView.descriptionLabel.text = "\(viewModel.tradeType.description) 희망가"
            processView.tradeBottomBar.tradeButton.setTitle("즉시 " + viewModel.tradeType.description,
                                                            for: .normal)
            processView.validateView.isHidden = false
        } else {
            processView.priceTextField.textField.text = viewModel.selectedProduct.price?.priceFormat
            processView.descriptionLabel.text = "즉시 \(viewModel.tradeType.description)가"
            processView.tradeBottomBar.tradeButton.setTitle("즉시 " + viewModel.tradeType.description,
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
    
    // MARK: 미구현
    @objc
    func didTapInspectButton() {
        print(#function)
    }
    
    @objc
    func didTapTradeButton() {
        viewModel.didTapTradeButton()
    }
}

extension ProcessViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        processView.priceTextField.textField.text = nil
        processView.segmentControl.selectedSegmentIndex = 0
        processView.validateView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let priceString = textField.text,
              let price = Int(priceString)
        else {
            viewModel.requestPrice.value = 0
            return
        }
        switch viewModel.tradeType {
        case .buy:
            if let askPrice = viewModel.selectedProduct.price {
                if price < askPrice {
                    viewModel.requestPrice.value = price
                    processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.description + " 입찰",
                                                                    for: .normal)
                } else {
                    processView.segmentControl.selectedSegmentIndex = 1
                    processView.tradeBottomBar.tradeButton.setTitle("즉시 " + viewModel.tradeType.description,
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
                    processView.tradeBottomBar.tradeButton.setTitle(viewModel.tradeType.description + " 입찰",
                                                                    for: .normal)
                } else {
                    processView.segmentControl.selectedSegmentIndex = 1
                    processView.tradeBottomBar.tradeButton.setTitle("즉시 " + viewModel.tradeType.description,
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
