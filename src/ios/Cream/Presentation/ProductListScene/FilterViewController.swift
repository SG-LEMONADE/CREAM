//
//  FilterViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/05.
//

import UIKit
import SnapKit

class FilterViewController: BaseDIViewController<FilterViewModel> {
    private lazy var filterView = FilterView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarItem()
        viewModel.viewDidLoad()
    }

    private func setupTableView() {
        filterView.filterTableView.delegate = self
        filterView.filterTableView.dataSource = self
    }
    
    private func setupNavigationBarItem() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseButton))
        
        let clearButton = UIBarButtonItem(title: "모두 삭제",
                                          style: .plain,
                                          target: self,
                                          action: #selector(didTapClearButton))
        title = "필터"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = clearButton
    }
    
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapClearButton() {
        print(#function)
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        content.text = "카테고리"
        content.secondaryText = "모든 카테고리"
        cell.contentConfiguration = content
        
        return cell
    }
}
