//
//  ShopViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit
import SnapKit

class ShopViewController: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "브랜드명, 모델명, 모델번호 등"
        return searchBar
    }()
    
    private lazy var shopCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
        let shopSearchController = UISearchController(searchResultsController: nil)
        
//        self.navigationItem.titleView = searchBar
        self.navigationItem.title = "Search"
        self.navigationItem.searchController = shopSearchController
        self.view.backgroundColor = .red
    }
}

extension ShopViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(shopCollectionView)
    }

    func setupConstraints() {
        shopCollectionView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.bottom.equalTo(view)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
        }
    }
}
