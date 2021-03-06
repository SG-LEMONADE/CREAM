//
//  MyPageViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/15.
//

import UIKit
import Toast_Swift

class MyPageViewController: DIViewController<MyPageViewModelInterface> {
    private lazy var myPageView = MyPageView()
    
    // MARK: View Life Cycle
    override func loadView() {
        self.view = myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarItem()
        registerCell()
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad()
    }
    
    
    func setupTableView() {
        myPageView.userTableView.delegate = self
        myPageView.userTableView.dataSource = self
    }
    
    func setupNavigationBarItem() {
        self.navigationController?.navigationBar.topItem?.title = "내 쇼핑"
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(pushToSettingViewController))
        navigationItem.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = navigationItem
    }
    
    func registerCell() {
        myPageView.userTableView.register(MyInfoCell.self,
                                          forCellReuseIdentifier: MyInfoCell.reuseIdentifier)
        myPageView.userTableView.register(MyTradeCell.self,
                                          forCellReuseIdentifier: MyTradeCell.reuseIdentifier)
        myPageView.userTableView.register(CompanyInfoCell.self,
                                          forCellReuseIdentifier: CompanyInfoCell.reuseIdentifier)
        myPageView.userTableView.register(WishItemHeaderView.self,
                                          forHeaderFooterViewReuseIdentifier: WishItemHeaderView.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.isFinished.bind { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.myPageView.userTableView.reloadData()
            }
        }
    }
    
    @objc func pushToSettingViewController() {
        guard let baseURL = URL(string: Integrator.gateWayURL)
        else { fatalError() }
    
        let config                  = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService          = DefaultNetworkService(config: config)
        let dataTransferService     = DefaultDataTransferService(with: networkService)
        let repository              = UserRepository(dataTransferService: dataTransferService)
        let usecase                 = UserUseCase(repository)
        let viewModel               = SettingViewModel(usecase)
        let settingViewController   = SettingViewController(viewModel)
        
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
}

extension MyPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return .one
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoCell.reuseIdentifier) as? MyInfoCell
            else { return UITableViewCell() }
            
            cell.delegate = self
            cell.configure(with: viewModel.userInfo)
            return cell
        } else if indexPath.section == .one {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTradeCell.reuseIdentifier) as? MyTradeCell
            else { return UITableViewCell() }

            cell.configure(ask: viewModel.askList,
                           bid: viewModel.bidList)
            
            cell.buyHistoryAction = { [weak self] in
                self?.didTapBuyHistoryButton()
            }
            cell.sellHistoryAction = { [weak self] in
                self?.didTapSellHistoryButton()
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyInfoCell.reuseIdentifier) as? CompanyInfoCell
            else { return UITableViewCell() }
            
            cell.noticeButtonAction = { [weak self] in
                self?.didTapNoticeButton()
            }
            cell.standardButtonAction = { [weak self] in
                self?.didTapStandardButton()
            }
            cell.penaltyButtonAction = { [weak self] in
                self?.didTapPenaltyButton()
            }
            cell.policyButtonAction = { [weak self] in
                self?.didTapPolicyButton()
            }
            cell.showRoomButtonAction = { [weak self] in
                self?.didTapShowRoomButton()
            }
            cell.offlineCSButtonAction = { [weak self] in
                self?.didTapOfflineCSButton()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == .one {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WishItemHeaderView.reuseIdentifier) as? WishItemHeaderView
            else { return nil }

            header.wishListAction = { [weak self] in
                self?.didTapWishList()
            }
            return header
        }
        return nil
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == .one {
            return 64
        }
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension MyPageViewController: ProfileReviseDelegate {
    func moveToProfileScene() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
}

// TODO: No Implement functions
extension MyPageViewController {
    func didTapWishList() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
    
    func didTapBuyHistoryButton() {
        let vm = ManagementViewModel(usecase: viewModel.usecase,
                                     tradeType: .buy,
                                     tradeState: .waiting)
        let vc = ManagementViewController(vm)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func didTapSellHistoryButton() {
        let vm = ManagementViewModel(usecase: viewModel.usecase,
                                     tradeType: .sell,
                                     tradeState: .waiting)
        let vc = ManagementViewController(vm)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapNoticeButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
    func didTapStandardButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
    func didTapPenaltyButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
    func didTapPolicyButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
    func didTapShowRoomButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
    func didTapOfflineCSButton() {
        DispatchQueue.main.async { [weak self] in
            self?.view.makeToast("준비 중입니다.", duration: 1.5, position: .center)
        }
    }
}
