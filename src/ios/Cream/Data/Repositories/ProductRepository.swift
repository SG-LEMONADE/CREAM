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

extension ProductRepository: ProductRepositoryInterface {
    func fetchHome(completion: @escaping ((Result<HomeData, Error>) -> Void)) -> Cancellable {
        let task = RepositoryTask()
        
        return task
    }
    
    func requestProducts(page: Int, completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.loadProducts(page)
        
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
