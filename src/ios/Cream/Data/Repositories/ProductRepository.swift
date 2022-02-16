//
//  ProductRepository.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

final class ProductRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - Product View Repository Interface
extension ProductRepository: ProductRepositoryInterface {

    func requestProducts(page: Int,
                         searchWord: String?,
                         category: String?,
                         sort: String?,
                         brandId: String?,
                         completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.loadProducts(page, searchWord: searchWord,
                                                 category: category,
                                                 sort: sort,
                                                 brandId: brandId)
        
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
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
                completion(.failure(error))
            }
        })
        return task
    }
    
    func addWishList(productId: Int, size: String, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        let endpoint = APIEndpoints.addToWishList(productId: productId, size: size)

        let task = RepositoryTask()
        
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
    }

}

// MARK: - Home View Repository Interface
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
                completion(.failure(error))
            }
        })
        return task
    }
}

extension ProductRepository: FilterRepositoryInterface {
    func fetchFilter(completion: @escaping ((Result<Filter, Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.loadFilter()
        
        let task = RepositoryTask()
        
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                let product = response.toDomain()
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
    }
}

extension ProductRepository: TradeRepositoryInterface {
    func fetchTradeInfo(with type: TradeType, completion: @escaping (Result<TradeList, Error>) -> Void) -> Cancellable {
        let endpoint = APIEndpoints.fetchTradeInfo(type: type)
        
        let task = RepositoryTask()
        
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                let product = response.toDomain()
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
    }
    
    func requestTrade(tradeType: TradeType,
                      productId: Int,
                      size: String,
                      price: Int,
                      validate: Int?,
                      completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        let endpoint = APIEndpoints.requestTrade(tradeType: tradeType,
                                                 productId: productId,
                                                 size: size,
                                                 price: price,
                                                 validate: validate)
        let task = RepositoryTask()
        
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
    }
}

