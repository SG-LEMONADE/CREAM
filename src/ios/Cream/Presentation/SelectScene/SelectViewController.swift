//
//  SelectViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import UIKit

@objc protocol SelectDelegate: AnyObject {
    @objc optional func updateListData(_ standard: String)
    @objc optional func didTapDeadline(_ deadline: Int)
    @objc optional func didTapSort(by sort: String)
    @objc optional func didRemoveFromWishlist(_ size: String)
    @objc optional func didSelectItem(_ size: String)
    @objc optional func didAppendToWishList(_ size: String)
    @objc optional func didTapSize(_ size: String)
}

final class SelectViewController: DIViewController<SelectViewModelInterface> {
    private lazy var selectView = SelectView(frame: .zero,
                                             defaultHeight: viewModel.heightInfo)
    
    var selectCompleteHandler: (() -> Void)?
    weak var delegate: SelectDelegate?
    
    // MARK: View Life Cycle
    override func loadView() {
        view = selectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDimmedViewGesture()
        setupNavigation()
        configureUserActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
        animateShowDimmedView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        selectCompleteHandler?()
    }
    
    private func setupCollectionView() {
        selectView.selectionView.delegate = self
        selectView.selectionView.dataSource = self
        registerCollectionViewCell()
        
        if case .wish(_,_) = viewModel.type {
            selectView.selectionView.allowsMultipleSelection = true
        }
    }
    
    private func setupNavigation() {
        selectView.titleLabel.text = viewModel.type.navigationTitle
    }
    
    func configureUserActions() {
        selectView.exitButton.addTarget(self,
                                        action: #selector(animateDismissView),
                                        for: .touchUpInside)
    }
    
    private func setupDimmedViewGesture() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        selectView.dimmedView.addGestureRecognizer(dimmedTap)
        selectView.dimmedView.isUserInteractionEnabled = true
    }
    
    private func animateShowDimmedView() {
        selectView.dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self
            else { return }
            
            self.selectView.dimmedView.alpha = self.selectView.maxDimmedAlpha
        }
    }
    
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.selectView.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheetAndGoBack() {
        selectView.containerViewHeightConstraint?.constant = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.selectView.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    private func registerCollectionViewCell() {
        selectView.selectionView.register(SizeListCell.self, forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        selectView.selectionView.register(WishCell.self, forCellWithReuseIdentifier: WishCell.reuseIdentifier)
        selectView.selectionView.register(SizePriceCell.self, forCellWithReuseIdentifier: SizePriceCell.reuseIdentifier)
        selectView.selectionView.register(SortCell.self, forCellWithReuseIdentifier: SortCell.reuseIdentifier)
        selectView.selectionView.register(DeadlineCell.self, forCellWithReuseIdentifier: DeadlineCell.reuseIdentifier)
    }
    
    @objc
    private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    @objc
    private func animateDismissView() {
        dismissView()
    }
    
    private func dismissView() {
        UIView.animate(withDuration: 0.3) {
            self.selectView.containerViewBottomConstraint?.constant = self.selectView.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        selectView.dimmedView.alpha = selectView.maxDimmedAlpha
        UIView.animate(withDuration: 0.3) {
            self.selectView.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
}

extension SelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let value = viewModel.items[indexPath.item]
        switch viewModel.type {
        case .wish:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishCell.reuseIdentifier, for: indexPath) as? WishCell
            else { return UICollectionViewCell() }
            
            if case let .wish(size, isSelected) = value {
                cell.configure(size: size, isSelected: isSelected)
                if isSelected {
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
                } else {
                    collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
            return cell
            
        case .size:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier, for: indexPath) as? SizeListCell
            else { return UICollectionViewCell() }
            
            
            if case let .size(size) = value {
                cell.configure(size: size)
            }
            return cell
            
        case .sizePrice:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizePriceCell.reuseIdentifier, for: indexPath) as? SizePriceCell
            else { return UICollectionViewCell() }
            
            
            if case let .sizePrice(size, price) = value {
                cell.configure(size: size, price: price)
            }
            return cell
            
        case .sort:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCell.reuseIdentifier, for: indexPath) as? SortCell
            else { return UICollectionViewCell() }
            
            
            if case let .sort(sequence) = value {
                cell.configure(sort: sequence)
            }
            return cell
            
        case .deadline:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeadlineCell.reuseIdentifier, for: indexPath) as? DeadlineCell
            else { return UICollectionViewCell() }
            
            
            if case let .deadline(date) = value {
                cell.configure(date: date)
            }
            return cell
        }
    }
}

extension SelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = viewModel.items[indexPath.item]
        switch viewModel.type {
        case .wish:
            if case let .wish(size, _) = value {
                delegate?.didAppendToWishList?(size)
            }
        case .size:
            if case let .size(size) = value {
                delegate?.didTapSize?(size)
            }
            dismissView()
        case .sizePrice:
            if case let .sizePrice(size, _) = value {
                delegate?.didSelectItem?(size)
            }
            dismissView()
            break
        case .sort:
            if case let .sort(sequence) = value {
                delegate?.didTapSort?(by: sequence)
            }
            dismissView()
        case .deadline:
            if case let .deadline(date) = value {
                delegate?.didTapDeadline?(date)
            }
            dismissView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let value = viewModel.items[indexPath.item]
        switch viewModel.type {
        case .wish:
            if case let .wish(size, _) = value {
                delegate?.didAppendToWishList?(size)
            }
        default:
            break
        }
    }
}

// MARK: CollectionView Layout & CollectionView Cell Configuration
extension SelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - (viewModel.numberOfColumns - 1) * SelectView.Constraint.GridWidthSpacing) / viewModel.numberOfColumns
        
        let cellLayout = CGSize(width: width,
                                height: width * 0.4)
        return cellLayout
    }
}

