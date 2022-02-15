//
//  DetailFilterViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import UIKit

class DetailFilterViewController: DIViewController<DetailFilterViewModelInterface> {
    
    private lazy var filterView = FilterView()
    private var selectedIndexPaths: [IndexPath] = []
    override func loadView() {
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarItem()
        configureUserActions()
        bindViewModel()
    }
    
    private func setupTableView() {
        filterView.filterTableView.delegate = self
        filterView.filterTableView.dataSource = self
        filterView.filterTableView.allowsMultipleSelection = viewModel.type.isEnableMultiSelect
    }
    
    private func setupNavigationBarItem() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(didTapPrevButton))
        
        let clearButton = UIBarButtonItem(title: "삭제",
                                          style: .plain,
                                          target: self,
                                          action: #selector(didTapClearButton))
        title = viewModel.type.description
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = clearButton
    }
    
    private func configureUserActions() {
        filterView.searchButton.addTarget(self,
                                          action: #selector(didTapSearchButton),
                                          for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.selectedList.bind { [weak self] _ in
            self?.filterView.filterTableView.reloadData()
        }
    }
    
    @objc
    func didTapPrevButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didTapClearButton() {
        viewModel.reinitSelected()
    }
    
    @objc
    func didTapSearchButton() {
        viewModel.didTapSearchButton()
        dismiss(animated: true, completion: nil)
    }
}

extension DetailFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.tintColor = .black
        cell.accessoryType = .none
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        let filter = viewModel.filter[indexPath.row]
        content.text = filter
        
        switch viewModel.type {
        case .category:
            if viewModel.selectedList.value.category == filter {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.accessoryType = .checkmark
            }
        case .brand:
            if viewModel.selectedList.value.brands.contains(filter) {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.accessoryType = .checkmark
            }
        case .gender:
            if viewModel.selectedList.value.gender == filter {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.accessoryType = .checkmark
            }
        case .collection:
            if viewModel.selectedList.value.collections.contains(filter) {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.accessoryType = .checkmark
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

extension DetailFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath)
        else { return }
        viewModel.didSelectRowAt(indexPath: indexPath)
        cell.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath)
        else { return }
        
        viewModel.didDeselectRowAt(indexPath: indexPath)
        cell.accessoryType = .none
    }
}
