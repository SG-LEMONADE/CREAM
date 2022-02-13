//
//  HomeListUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

protocol HomeListUseCaseInterface {
    func fetchHome(completion: @escaping ((Result<HomeInfo, Error>) -> Void)) -> Cancellable
}

final class HomeListUseCase {
    private let repository: HomeListRepositoryInterface
    
    init(repository: HomeListRepositoryInterface) {
        self.repository = repository
    }
}

extension HomeListUseCase: HomeListUseCaseInterface {
    func fetchHome(completion: @escaping ((Result<HomeInfo, Error>) -> Void)) -> Cancellable {
        repository.fetchHome { result in
            switch result {
            case .success(let homedata):
                completion(.success(homedata))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
