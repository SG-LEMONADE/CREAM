//
//  SettingViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import UIKit
import SwiftKeychainWrapper

protocol SettingViewModelInput {
    func didTapLogoutButton(completion: @escaping (Result<Void, Error>) -> Void)
}
protocol SettingViewModelOutput {
    var numberOfSections: Int { get }
    var sectionTitles: [String] { get set }
    var sectionInfo: [[String]] { get set }
}
protocol SettingViewModel: SettingViewModelInput, SettingViewModelOutput { }

final class DefaultSettingViewModel: SettingViewModel {
    var sectionTitles: [String] = ["일반", "정보"]
    var sectionInfo: [[String]] = [["로그인 정보", "주소록"], ["로그아웃"]]
    let usecase: UserUseCaseInterface
    
    init(_ usecase: UserUseCaseInterface) {
        self.usecase = usecase
    }
    var numberOfSections: Int {
        return 2
    }
    
    func didTapLogoutButton(completion: @escaping (Result<Void, Error>) -> Void) {
        usecase.removeToken { result in
            switch result {
            case .success(let void):
                KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.accessToken)
                KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.refreshToken)
                completion(.success(void))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class SettingView: UIView {
    lazy var settingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(settingTableView)
    }
    
    func setupConstraints() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func viewConfigure() {
        settingTableView.backgroundColor = .white
    }
}


class SettingViewController: BaseDIViewController<SettingViewModel> {
    
    private lazy var settingView = SettingView()
    
    override func loadView() {
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarItem()
    }
    
    func setupTableView() {
        settingView.settingTableView.delegate = self
        settingView.settingTableView.dataSource = self
    }
    
    func setupNavigationBarItem() {
        self.title = "설정"
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(popToPrevViewController))
        navigationItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = navigationItem
    }
    
    @objc
    func popToPrevViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sectionInfo[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var context = cell.defaultContentConfiguration()
        context.text = viewModel.sectionInfo[indexPath.section][indexPath.row]
        if indexPath.section == .one {
            context.textProperties.color = .red
        }
        cell.contentConfiguration = context
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == .one {
            let actionSheetViewController = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .actionSheet)
            
            actionSheetViewController.addAction(.init(title: "로그아웃", style: .destructive, handler: { [weak self] _ in
                
                self?.viewModel.didTapLogoutButton { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.navigationController?.tabBarController?.selectedIndex = 0
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }))
            actionSheetViewController.addAction(.init(title: "취소", style: .cancel, handler: nil))
            present(actionSheetViewController, animated: true, completion: nil)
        }
    }
}
