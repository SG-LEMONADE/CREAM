//
//  SizeListViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import UIKit

protocol SizeSelectDelegate: NSObject {
    func configureShoesSize(_ size: Int)
}

final class SizeListViewController: BaseDIViewController<SizeListViewModel> {
    
    private lazy var sizeView = SizeListView()
    
    weak var delegate: SizeSelectDelegate?
    private var isJoinProcess: Bool = true
    
    override init(_ viewModel: SizeListViewModel) {
        super.init(viewModel)
    }
    
    convenience init(_ viewModel: SizeListViewModel, isJoinProcess: Bool) {
        self.init(viewModel)
        self.isJoinProcess = isJoinProcess

    }
    
    // MARK: View Life Cycle
    override func loadView() {
        self.view = sizeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUserActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func configureCollectionView() {
        sizeView.sizeCollectionView.delegate = self
        sizeView.sizeCollectionView.dataSource = self
        sizeView.sizeCollectionView.register(SizeListCell.self, forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
    }
    
    func animateShowDimmedView() {
        sizeView.dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self
            else { return }
            
            self.sizeView.dimmedView.alpha = self.sizeView.maxDimmedAlpha
        }
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.sizeView.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func configureUserActions() {
        sizeView.exitButton.addTarget(self,
                                      action: #selector(animateDismissView),
                                      for: .touchUpInside)
    }
    
    @objc func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.sizeView.containerViewBottomConstraint?.constant = self.sizeView.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        sizeView.dimmedView.alpha = sizeView.maxDimmedAlpha
        UIView.animate(withDuration: 0.3) {
            self.sizeView.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
}
// MARK: CollectionView Layout & CollectionView Cell Configuration
extension SizeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellLayout = CGSize(width: (collectionView.bounds.size.width - (viewModel.numberOfColumns - 1) * SizeListView.Constraint.GridWidthSpacing) / viewModel.numberOfColumns,
                                height: ((collectionView.bounds.size.width - SizeListView.Constraint.GridHeightSpacing) / 3) * 0.35)
        return cellLayout
    }
}

extension SizeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isJoinProcess {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier,
                                                                for: indexPath) as? SizeListCell
            else { return UICollectionViewCell() }
            
            viewModel.getCellViewModel(at: indexPath) {
                cell.configure(size: $0)
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier,
                                                                for: indexPath) as? SizeListCell
            else { return UICollectionViewCell() }
            
            viewModel.getCellViewModel(at: indexPath) {
                cell.configure(size: $0)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectSize(at: indexPath) { [weak self] sizeString in
            guard let self = self,
                  let size = Int(sizeString)
            else { return }
            
            self.delegate?.configureShoesSize(size)
            UIView.animate(withDuration: 0.3) {
                self.sizeView.containerViewBottomConstraint?.constant = self.sizeView.defaultHeight
                self.view.layoutIfNeeded()
            }
            
            self.sizeView.dimmedView.alpha = self.sizeView.maxDimmedAlpha
            UIView.animate(withDuration: 0.3) {
                self.sizeView.dimmedView.alpha = 0
            } completion: { _ in
                self.dismiss(animated: true)
            }
        }
    }
}
