//
//  FilterViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/09.
//

import Foundation

typealias Filters = [Filter]

struct Filter { }

// MARK: - UseCase
protocol FilterUseCaseInterface {
    func fetch(category: String?, collections: [String: Any]?, completion: @escaping (Result<Filters, Error>) -> Void)
}

final class FilterUseCase: FilterUseCaseInterface {
    func fetch(category: String?, collections: [String: Any]?, completion: @escaping (Result<Filters, Error>) -> Void) {
        
    }
}

// MARK: - ViewModel
protocol FilterViewModelInput {
    func viewDidLoad()
}

protocol FilterViewModelOutput {
    var products: Observable<Products> { get set }
}

protocol FilterViewModel: FilterViewModelInput, FilterViewModelOutput { }

final class DefaultFilterViewModel: FilterViewModel {
    var products: Observable<Products> = Observable([])
    var filter: Observable<[String]> = Observable([])
    var usecase: FilterUseCaseInterface
    
    init(_ usecase: FilterUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        // TODO: Load FilterCases
    }
}
