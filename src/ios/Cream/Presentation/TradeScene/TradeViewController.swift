//
//  TradeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/23.
//

import UIKit
import SnapKit


class TradeViewController: BaseDIViewController<TradeViewModel> {

    private lazy var tradeView = TradeView()
    
    override init(_ viewModel: TradeViewModel) {
        super.init(viewModel)
    }
    
    override func loadView() {
        self.view = tradeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tradeView.sizeListView.dataSource = self
        tradeView.sizeListView.delegate = self
        tradeView.sizeListView.register(SizeListCell.self, forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
    }
}

// MARK: CollectionView Layout & CollectionView Cell Configuration
extension TradeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellLayout = CGSize(width: (collectionView.bounds.size.width - 1 * TradeView.Constraint.GridWidthSpacing) / 2, height: ((collectionView.bounds.size.width - TradeView.Constraint.GridHeightSpacing) / 2) * 0.25)
        return cellLayout
    }
}

extension TradeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier, for: indexPath) as? SizeListCell else { return UICollectionViewCell() }
        
//        viewModel?.getCellViewModel(at: indexPath) {
//            cell.configure(with: $0)
//        }
        
        return cell
    }
}
