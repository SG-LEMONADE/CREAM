//
//  ProcessViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/03.
//

import UIKit

class ProcessViewController: DIViewController<ProcessViewModelInterface>, ImageLoadable {
    
    // MARK: Property
    var session: URLSessionDataTask?
    
    private lazy var processView = ProcessView()
    
    override func loadView() {
        self.view = processView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInputTextField()
        setupSegmentControl()
        configureView()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addBorder()
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
            let button = UIButton.init(type: .custom)
            button.setTitle("검수 기준", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
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
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == .zero {
            processView.priceTextField.textField.text = nil
            processView.descriptionLabel.text = "\(viewModel.tradeType.description) 희망가"
            processView.tradeBottomBar.tradeButton.setTitle("즉시 " + viewModel.tradeType.description,
                                                            for: .normal)
            
        } else {
            processView.priceTextField.textField.text = viewModel.selectedProduct.price?.priceFormat
            processView.descriptionLabel.text = "즉시 \(viewModel.tradeType.description)가"
            processView.tradeBottomBar.tradeButton.setTitle("즉시 " + viewModel.tradeType.description,
                                                            for: .normal)
            if let price = viewModel.selectedProduct.price {
                processView.tradeBottomBar.totalLabel.priceLabel.text = "\((price+viewModel.deliveryPrice).priceFormat) 원"
            }
        }
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
    }
    
    private func addBorder(thickness: CGFloat = 0.5, color: UIColor = .systemGray3) {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0,
                                 width: processView.tradeBottomBar.frame.size.width,
                                 height: thickness)
        topBorder.backgroundColor = color.cgColor
        processView.tradeBottomBar.layer.addSublayer(topBorder)
    }
    
    private func configureView() {
        if viewModel.tradeType == .buy {
            processView.deliveryValueLabel.text = viewModel.deliveryPrice.priceFormat + "원"
        } else {
            processView.deliveryValueLabel.text = "선불﹒판매자 부담"
        }
        
        processView.productInfoView.itemNumberLabel.text = viewModel.product.styleCode
        processView.productInfoView.itemTitleLabel.text = viewModel.product.originalName
        processView.productInfoView.itemTranslatedLabel.text = viewModel.product.translatedName
        processView.productInfoView.sizeLabel.text = viewModel.selectedProduct.size
        processView.tradeBottomBar.totalLabel.tradeTypeLabel.text = viewModel.tradeType.bottomDescription
        
        if let askPrice = viewModel.product.askPrices[viewModel.selectedProduct.size] {
            askPrice.flatMap {
                processView.buyLabel.priceLabel.text = $0.priceFormat + "원"
                processView.segmentControl.selectedSegmentIndex = 1
                processView.priceTextField.textField.text = $0.priceFormat
            }
        } else {
            processView.buyLabel.priceLabel.text = "-"
        }
        if let bidPrice = viewModel.product.bidPrices[viewModel.selectedProduct.size] {
            bidPrice.flatMap {
                processView.sellLabel.priceLabel.text = $0.priceFormat + "원"
                processView.segmentControl.selectedSegmentIndex = 1
                processView.priceTextField.textField.text = $0.priceFormat
            }
            processView.isUserInteractionEnabled = true
        } else {
            processView.sellLabel.priceLabel.text = "-"
            processView.segmentControl.isUserInteractionEnabled = false
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
        
        
        session = loadImage(url: url, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.processView.productInfoView.modelImageView.image = image
            }
        })
    }
    
    @objc
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapInputField(sender: UITapGestureRecognizer) {
        viewModel.didTapInputField()
        print("input field")
    }
}

extension ProcessViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        processView.priceTextField.textField.text = nil
        processView.segmentControl.selectedSegmentIndex = 0
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
