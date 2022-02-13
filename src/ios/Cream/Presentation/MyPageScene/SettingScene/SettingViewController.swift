//
//  SettingViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import UIKit

class SettingViewController: DIViewController<SettingViewModelInterface> {
    private lazy var settingView = SettingView()
    
    // MARK: View Life Cycle
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
        title = "설정"
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(popToPrevViewController))
        navigationItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = navigationItem
    }
    
    @objc
    func popToPrevViewController() {
        navigationController?.popViewController(animated: true)
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
            let actionSheetViewController = UIAlertController(title: "로그아웃 하시겠습니까?",
                                                              message: nil,
                                                              preferredStyle: .actionSheet)
            actionSheetViewController.addAction(.init(title: "로그아웃",
                                                      style: .destructive,
                                                      handler: { [weak self] _ in
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
