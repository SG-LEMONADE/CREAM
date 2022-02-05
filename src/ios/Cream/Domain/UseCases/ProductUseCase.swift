//
//  ProductUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

protocol ProductUseCaseInterface {
    func fetch(page: Int, category: String?, completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable
    func fetchItemById(_ id: Int, completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable
}

final class ProductUseCase {
    var repository: ProductRepositoryInterface
    
    init(_ repository: ProductRepositoryInterface) {
        self.repository = repository
    }
}

extension ProductUseCase: ProductUseCaseInterface {
    // TODO: 목록 요청
    @discardableResult
    func fetch(page: Int, category: String?, completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable {
        repository.requestProducts(page: page, category: category) { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // TODO: 특정 Product 요청
    @discardableResult
    func fetchItemById(_ id: Int, completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable {
        repository.requestProductById(id) { result in
            switch result {
            case .success(let product):
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
