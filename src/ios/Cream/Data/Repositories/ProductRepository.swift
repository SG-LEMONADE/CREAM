//
//  ProductRepository.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation
import SwiftKeychainWrapper

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
    
    func requestProductById(_ id: Int,
                            size: String?,
                            completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable {
        
        let endpoint = APIEndpoints.loadProduct(id, size: size)
        print(endpoint.path)
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

    func fetchPrice(id: Int, size: String?, completion: @escaping ((Result<[[PriceList]], Error>) -> Void)) -> Cancellable {
        let endpoint = APIEndpoints.fetchPrice(id: id, size: size)

        let task = RepositoryTask()
        
        task.networkTask = dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
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
                if response.recommendedItems.isEmpty {
                    _ = self.requestProducts(page: 0,
                                    searchWord: nil,
                                    category: nil,
                                    sort: nil,
                                    brandId: nil) { newInfo in
                        switch newInfo {
                        case .success(let product):
                            var homeInfo = response.toDomain()
                            if let _ = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.accessToken) {
                                homeInfo.sections[0] = Section(header: "아직 추천 정보가 부족합니다😭",
                                                               detail: "다른 사람들은 이런 상품을 좋아해요",
                                                               imageUrl: "",
                                                               products: product)
                            } else {
                                homeInfo.sections[0] = Section(header: "다른 사람들은 이런 상품을 좋아해요",
                                                               detail: "로그인하시면 `당신`만을 위한 아이템을 추천해드릴게요",
                                                               imageUrl: "",
                                                               products: product)
                            }
                            completion(.success(homeInfo))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
                completion(.success(response.toDomain()))
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
    
    func deleteTrade(id: Int, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        let endpoint = APIEndpoints.deleteTrade(id: id)
        
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

