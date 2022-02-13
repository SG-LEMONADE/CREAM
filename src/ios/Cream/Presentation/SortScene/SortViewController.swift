//
//  SortViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/09.
//

import UIKit

protocol SortSelectDelegate: AnyObject {
    func updateListData(_ standard: String)
}

final class SortViewController: DIViewController<SortViewModelInterface> {
    
    private lazy var sortView = SortView(frame: .zero,
                                         defaultHeight: viewModel.heightInfo)
    
    weak var delegate: SortSelectDelegate?
    
    // MARK: View Life Cycle
    override func loadView() {
        view = sortView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDimmedViewGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    private func setupTableView() {
        sortView.sortTableView.delegate = self
        sortView.sortTableView.dataSource = self
    }
    
    private func setupDimmedViewGesture() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        sortView.dimmedView.addGestureRecognizer(dimmedTap)
        sortView.dimmedView.isUserInteractionEnabled = true
    }
    
    private func animateShowDimmedView() {
        sortView.dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self
            else { return }
            
            self.sortView.dimmedView.alpha = self.sortView.maxDimmedAlpha
        }
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.sortView.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }

    private func hideBottomSheetAndGoBack() {
        sortView.containerViewHeightConstraint?.constant = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.sortView.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    @objc
    private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    @objc
    private func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.sortView.containerViewBottomConstraint?.constant = self.sortView.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        sortView.dimmedView.alpha = sortView.maxDimmedAlpha
        UIView.animate(withDuration: 0.3) {
            self.sortView.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension SortViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return .one
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .black
        content.text = viewModel.filters[indexPath.row].translatedString
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SortViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        delegate?.updateListData(viewModel.filters[indexPath.row].description)
        UIView.animate(withDuration: 0.3) {
            self.sortView.containerViewBottomConstraint?.constant = self.sortView.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        sortView.dimmedView.alpha = sortView.maxDimmedAlpha
        UIView.animate(withDuration: 0.3) {
            self.sortView.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
}
