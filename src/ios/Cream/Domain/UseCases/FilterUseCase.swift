//
//  FilterUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

// MARK: - UseCase
protocol FilterUseCaseInterface {
    func fetchFilter(completion: @escaping (Result<Filter, Error>) -> Void)
}

final class FilterUseCase {
    private let repository: FilterRepositoryInterface
    
    init(_ repository: FilterRepositoryInterface) {
        self.repository = repository
    }
}

extension FilterUseCase: FilterUseCaseInterface {
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
