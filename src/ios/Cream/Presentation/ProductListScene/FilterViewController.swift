//
//  FilterViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/05.
//

import UIKit
import SnapKit

protocol FilterViewModelInput {
    func viewDidLoad()
}

protocol FilterViewModelOutput {
    var products: Observable<Products> { get set }
}

protocol FilterViewModel: FilterViewModelInput, FilterViewModelOutput { }

final class DefaultFilterViewModel: FilterViewModel {
    var products: Observable<Products> = Observable([])
    var filter: Observable<[String]> = Observable([])
    func viewDidLoad() {
        // TODO: Load FilterCases
        print(#function)
    }
}

class FilterViewController: BaseDIViewController<FilterViewModel> {
    private lazy var filterView = FilterView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarItem()
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
        self.title = "필터"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.leftBarButtonItem = closeButton
        self.navigationItem.rightBarButtonItem = clearButton
    }
    
    @objc
    func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapClearButton() {
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

final class FilterView: UIView {
    lazy var filterTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.contentHorizontalAlignment = .center
        button.setTitle("결과보기", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(filterTableView, searchButton)
    }
    
    func setupConstraints() {
        filterTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(searchButton.snp.top).offset(10)
        }
        
        searchButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalTo(self.snp.leading).inset(10)
            $0.trailing.equalTo(self.snp.trailing).inset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func viewConfigure() {
        backgroundColor = .white
    }
}
