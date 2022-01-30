//
//  HomeViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

import Foundation

protocol HomeListViewModelInterface {
    var products: Observable<[Product]> { get }
    func fetch()
}
protocol HomeListUseCaseInterface {
    func fetch()
}

final class HomeListUseCase {
    private let repository: HomeListRepositoryInterface
    
    init(repository: HomeListRepositoryInterface) {
        self.repository = repository
    }
}

protocol HomeListRepositoryInterface {
    func fetch()
}

final class HomeListViewModel: HomeListViewModelInterface {
    private let usecase: HomeListUseCaseInterface
    private(set) var products: Observable<[Product]>
    
    init(usecase: HomeListUseCaseInterface) {
        self.usecase = usecase
        self.products = Observable([])
    }
    
    func fetch() {
         
    }
}


protocol HomeViewModelDelegate: AnyObject {
    func didStartFetchingMessage()
    func didFinishFetchingMessage(_ message: String)
}

class HomeViewModel {

    private let test: String
    
    weak var delegate: HomeViewModelDelegate?
    
    init(_ test: String) {
        self.test = test
    }
    
    func fetchMessage() {
        delegate?.didStartFetchingMessage()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let message = "Hello there"
            DispatchQueue.main.async {
                self.delegate?.didFinishFetchingMessage(message)
            }
        }
    }
}
