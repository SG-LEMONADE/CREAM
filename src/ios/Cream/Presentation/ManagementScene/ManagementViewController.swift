//
//  ManagementViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/20.
//

import UIKit

class ManagementViewController: DIViewController<ManagementViewModelInterface> {
    
    private lazy var managementView = ManagementView()
    
    override func loadView() {
        self.view = managementView
    }
    
    override func viewDidLoad() {
        setupTableView()
        setupNavigationBar()
        setupUserAction()
        viewModel.viewDidLoad()
        bindViewModel()
    }
    
    func setupTableView() {
        managementView.tradeTabelView.delegate = self
        managementView.tradeTabelView.dataSource = self
        managementView.tradeTabelView.register(ManagementCell.self,
                                               forCellReuseIdentifier: ManagementCell.reuseidentifer)
    }
    
    func setupNavigationBar() {
        let navigationItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapPrevButton))
        navigationItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = navigationItem
        self.navigationController?.navigationBar.backgroundColor = .clear
        title = viewModel.tradeType.titleLabel
    }
    
    func setupUserAction() {
        let bidViewGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBidView(sender:)))
        managementView.bidHistoryView.addGestureRecognizer(bidViewGesture)
        
        let progressViewGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProgressView(sender:)))
        managementView.progressHistoryView.addGestureRecognizer(progressViewGesture)
        
        let completeViewGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCompleteView(sender:)))
        managementView.completeHistoryView.addGestureRecognizer(completeViewGesture)
    }
    
    func bindViewModel() {
        viewModel.selectedList.bind { [weak self] trade in
            self?.managementView.tradeTabelView.reloadData()
        }
        
        viewModel.totalList.bind { [weak self] info in
            self?.managementView.bidHistoryView.countLabel.text = "\(info.counter.waitingCnt)"
            self?.managementView.progressHistoryView.countLabel.text = "\(info.counter.inProgressCnt)"
            self?.managementView.completeHistoryView.countLabel.text = "\(info.counter.finishedCnt)"
            self?.managementView.bidHistoryView.countLabel.textColor = self?.viewModel.tradeType.color
            self?.managementView.progressHistoryView.countLabel.textColor = self?.viewModel.tradeType.color
            self?.managementView.completeHistoryView.countLabel.textColor = self?.viewModel.tradeType.color
            
        }
    }
    
    @objc
    func didTapPrevButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    func didTapBidView(sender: UITapGestureRecognizer) {
        viewModel.didTapBidView()
        managementView.bidUnderView.backgroundColor = .black
        managementView.progressUnderView.backgroundColor = .systemGray6
        managementView.completeUnderView.backgroundColor = .systemGray6
    }
    
    @objc
    func didTapProgressView(sender: UITapGestureRecognizer) {
        viewModel.didTapProgressView()
        managementView.bidUnderView.backgroundColor = .systemGray6
        managementView.progressUnderView.backgroundColor = .black
        managementView.completeUnderView.backgroundColor = .systemGray6
    }
    
    @objc
    func didTapCompleteView(sender: UITapGestureRecognizer) {
        viewModel.didTapCompleteView()
        managementView.bidUnderView.backgroundColor = .systemGray6
        managementView.progressUnderView.backgroundColor = .systemGray6
        managementView.completeUnderView.backgroundColor = .black
    }
}


extension ManagementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManagementCell.reuseidentifer) as? ManagementCell
        else { return UITableViewCell() }
        
        cell.configure(trade: viewModel.selectedList.value[indexPath.row])
        
        return cell
    }
}

extension ManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            viewModel.deleteTrade(at: indexPath)
        }
    }
}
