//
//  FilterViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/05.
//

import UIKit
import SnapKit

enum FilterCategory: Int {
    case category, brand, gender, collection
    
    var description: String {
        switch self {
        case .category:     return "카테고리"
        case .brand:        return "브랜드"
        case .gender:       return "성별"
        case .collection:   return "콜렉션"
        }
    }
    
    var isEnableMultiSelect: Bool {
        switch self {
        case .category, .gender:
            return false
        case .collection, .brand:
            return true
        }
    }
}

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
        configureUserActions()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterView.filterTableView.reloadData()
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
    
    private func configureUserActions() {
        filterView.searchButton.addTarget(self,
                                          action: #selector(didTapSearchButton),
                                          for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.detailFilters.bind { [weak self] filter in
            self?.filterView.filterTableView.reloadData()
        }
    }
    
    @objc
    private func didTapCloseButton() {
        NotificationCenter.default.post(name: .filterCancelNotification, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapClearButton() {
        viewModel.selectedFilters.value.category = nil
        viewModel.selectedFilters.value.brands = []
        viewModel.selectedFilters.value.collections = []
        viewModel.selectedFilters.value.gender = nil
        
        DispatchQueue.main.async { [weak self] in
            self?.filterView.filterTableView.reloadData()
        }
    }
    
    @objc
    func didTapSearchButton() {
        viewModel.didTapSearchButton()
        dismiss(animated: true, completion: nil)
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
        content.text = viewModel.filterList[indexPath.row]
        content.secondaryText = "모든 \(viewModel.filterList[indexPath.row])"
        
        if indexPath.row == .zero {
            viewModel.selectedFilters.value.category.flatMap {
                content.secondaryText = $0
                content.secondaryTextProperties.color = .black
            }
        } else if indexPath.row == .one && !viewModel.selectedFilters.value.brands.isEmpty {
            content.secondaryText = viewModel.selectedFilters.value.brandsToString()
            content.secondaryTextProperties.color = .black
        } else if indexPath.row == 2 {
            viewModel.selectedFilters.value.gender.flatMap {
                content.secondaryText = $0
                content.secondaryTextProperties.color = .black
            }
        }
        cell.contentConfiguration = content
        
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = FilterCategory(rawValue: indexPath.row)
        else { return }
        
        guard let baseURL = URL(string: Integrator.gateWayURL)
        else { fatalError() }
        
        let config               = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService       = DefaultNetworkService(config: config)
        let dataTranferService   = DefaultDataTransferService(with: networkService)
        let repository           = ProductRepository(dataTransferService: dataTranferService)
        let usecase              = ProductUseCase(repository)
        let detailFilterViewModel: DetailFilterViewModel?
        switch category {
        case .category:
            detailFilterViewModel = DetailFilterViewModel(usecase: usecase,
                                                          filter: viewModel.detailFilters.value.categories,
                                                          type: .category,
                                                          totalFilter: viewModel.detailFilters.value,
                                                          selectedList: viewModel.selectedFilters)
        case .brand:
            var filters: [String] = []
            viewModel.detailFilters.value.brands.forEach {
                filters.append($0.toTranslatedName())
            }
            detailFilterViewModel = DetailFilterViewModel(usecase: usecase,
                                                          filter: filters,
                                                          type: .brand,
                                                          totalFilter: viewModel.detailFilters.value,
                                                          selectedList: viewModel.selectedFilters)
            
        case .gender:
            detailFilterViewModel = DetailFilterViewModel(usecase: usecase,
                                                          filter: viewModel.detailFilters.value.gender,
                                                          type: .gender,
                                                          totalFilter: viewModel.detailFilters.value,
                                                          selectedList: viewModel.selectedFilters)
            
        case .collection:
            detailFilterViewModel = DetailFilterViewModel(usecase: usecase,
                                                          filter: viewModel.detailFilters.value.collections,
                                                          type: .collection,
                                                          totalFilter: viewModel.detailFilters.value,
                                                          selectedList: viewModel.selectedFilters)
        }
        
        detailFilterViewModel.flatMap {
            let detailViewController = DetailFilterViewController($0)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
