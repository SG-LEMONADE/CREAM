//
//  ProductRepository.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

final class ProductRepository {
    private var dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: Product View Repository Interface
extension ProductRepository: ProductRepositoryInterface {
    func requestProducts(page: Int, category: String?, completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.loadProducts(page, category: category)
        
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                print(response)
                var result: Products = []
                response.forEach {
                    result.append($0.toDomain())
                }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func requestProductById(_ id: Int, completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.loadProduct(id)
        
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                let product = response.toDomain()
                completion(.success(product))
            case .failure(let error):
                print(error)
            }
        })
        return task
    }
}

// MARK: Home View Repository Interface
extension ProductRepository: HomeListRepositoryInterface {
    func fetchHome(completion: @escaping ((Result<HomeInfo, Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.loadHome()
        
        let task = RepositoryTask()
                
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                let product = response.toDomain()
                completion(.success(product))
            case .failure(let error):
                print(error)
            }
        })
        return task
    }
}
