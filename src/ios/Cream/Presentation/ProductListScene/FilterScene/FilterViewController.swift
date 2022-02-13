//
//  FilterViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/05.
//

import UIKit
import SnapKit

class FilterViewController: DIViewController<FilterViewModelInterface> {
    private lazy var filterView = FilterView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarItem()
        bindViewModel()
        viewModel.viewDidLoad()
    }

    private func setupTableView() {
        filterView.filterTableView.delegate = self
        filterView.filterTableView.dataSource = self
    }
    
    private func setupNavigationBarItem() {
        let closeButton = UIBarButtonItem(title: "취소",
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
    
    private func bindViewModel() {
        viewModel.filter.bind { [weak self] filter in
            self?.filterView.filterTableView.reloadData()
        }
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

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        content.secondaryTextProperties.color = .systemGray3
        content.text = viewModel.filterKind[indexPath.row]
        content.secondaryText = "모든 \(viewModel.filterKind[indexPath.row])"
        cell.contentConfiguration = content
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let baseURL = URL(string: "http://1.231.16.189:8081")
        else { fatalError() }
        
        let config               = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService       = DefaultNetworkService(config: config)
        let dataTranferService   = DefaultDataTransferService(with: networkService)
        let repository           = ProductRepository(dataTransferService: dataTranferService)
        let usecase              = FilterUseCase(repository)
        let filterViewModel      = FilterViewModel(usecase)
        let filterViewController = FilterViewController(filterViewModel)
        
        navigationController?.pushViewController(filterViewController, animated: true)
    }
}
