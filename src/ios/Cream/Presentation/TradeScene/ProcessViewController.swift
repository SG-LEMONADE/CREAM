//
//  ProcessViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/03.
//

import UIKit

class ProcessViewController: BaseDIViewController<ProcessViewModel> {
    private lazy var processView = ProcessView()
    
    override func loadView() {
        self.view = processView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
