//
//  DetailFilterViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import UIKit



class DetailFilterViewController: DIViewController<DetailFilterViewModelInterface> {
    
    private lazy var filterView = FilterView()
    
    override func loadView() {
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         return UITableViewCell()
    }
}

extension DetailFilterViewController: UITableViewDelegate {
    
}
