//
//  DetailFilterViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

protocol DetailFilterViewModelInput {
    func viewDidLoad()
}
protocol DetailFilterViewModelOutput { }

protocol DetailFilterViewModelInterface: DetailFilterViewModelInput, DetailFilterViewModelOutput { }

final class DetailFilterViewModel: DetailFilterViewModelInterface {
    
    func viewDidLoad() {
        
    }
}


