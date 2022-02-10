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

protocol ProcessViewModel: ProcessViewModelInput, ProcessViewModelOutput {
    
}

final class DefaultProcessViewModel: ProcessViewModel {
    func viewDidLoad() {
         
    }
}
