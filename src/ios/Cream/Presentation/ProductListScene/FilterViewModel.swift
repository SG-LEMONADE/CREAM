//
//  FilterViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/09.
//

import Foundation

protocol FilterRepositoryInterface {
    func fetchFilter(completion: @escaping ((Result<Filter, Error>) -> Void)) -> Cancellable
}


// MARK: - UseCase
protocol FilterUseCaseInterface {
    func fetch(category: String?, collections: [String: Any]?, completion: @escaping (Result<Filter, Error>) -> Void)
    func fetchFilter(completion: @escaping (Result<Filter, Error>) -> Void)
}

final class FilterUseCase {
    private let repository: FilterRepositoryInterface
    
    init(_ repository: FilterRepositoryInterface) {
        self.repository = repository
    }
}

extension FilterUseCase: FilterUseCaseInterface {
    func fetch(category: String?, collections: [String: Any]?, completion: @escaping (Result<Filter, Error>) -> Void) {
        
    }
    
    func fetchFilter(completion: @escaping (Result<Filter, Error>) -> Void) {
        _ = repository.fetchFilter { result in
            switch result {
            case .success(let filter):
                completion(.success(filter))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - ViewModel
protocol FilterViewModelInput {
    func viewDidLoad()
}

protocol FilterViewModelOutput {
    var products: Observable<Products> { get set }
    var filterKind: [String] { get set }
    var filter: Observable<Filter> { get set }
    var numberOfCells: Int { get }
}

protocol FilterViewModelInterface: FilterViewModelInput, FilterViewModelOutput { }

final class FilterViewModel: FilterViewModelInterface {
    
    var products: Observable<Products> = Observable([])
    var filterKind: [String] = ["카테고리", "브랜드", "성별", "컬렉션"]
    var filter: Observable<Filter> = Observable(.init(categories: [],
                                                      brands: [],
                                                      collections: [],
                                                      gender: []))
    
    var numberOfCells: Int {
        return filterKind.count
    }
    
    private let usecase: FilterUseCaseInterface
    
    init(_ usecase: FilterUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        // TODO: Load FilterCases
        _ = usecase.fetchFilter { result in
            switch result {
            case .success(let filter):
                print(filter)
                self.filter.value = filter
            case .failure(_):
                break
            }
        }
    }
}
