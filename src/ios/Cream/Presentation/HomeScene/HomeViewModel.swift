//
//  HomeViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

import Foundation

protocol HomeListRepositoryInterface {
    func fetchHome(completion: @escaping ((Result<HomeInfo, Error>) -> Void)) -> Cancellable
}

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

protocol HomeListViewModelInput {
    func viewDidLoad()
    func didTapProduct(indexPath: IndexPath)
}

protocol HomeListViewModelOutput {
    var homeInfo: Observable<HomeInfo> { get set }
    var numberOfSections: Int { get }
}

protocol HomeListViewModel: HomeListViewModelInput, HomeListViewModelOutput { }

final class DefaultHomeListViewModel: HomeListViewModel {
    var homeInfo: Observable<HomeInfo> = Observable(.init(ads: [], sections: []))
    var usecase: HomeListUseCaseInterface
    
    var numberOfSections: Int {
        return homeInfo.value.sections.count * 2
    }
    
    var numberOfItems: Int {
        homeInfo.value.sections[0].products.count
    }
    
    init(_ usecase: HomeListUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        _ = usecase.fetchHome { result in
            switch result {
            case .success(let homeInfo):
                self.homeInfo.value = homeInfo
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapProduct(indexPath: IndexPath) {
        // TODO: CollectionView Click Event 발생 시
    }
}
