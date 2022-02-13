//
//  ProcessViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/04.
//

import Foundation

protocol ProcessViewModelInput {
    func viewDidLoad()
}

protocol ProcessViewModelOutput {
    
}

protocol ProcessViewModelInterface: ProcessViewModelInput, ProcessViewModelOutput {
    
}

final class ProcessViewModel: ProcessViewModelInterface {
    func viewDidLoad() {
         
    }
}
