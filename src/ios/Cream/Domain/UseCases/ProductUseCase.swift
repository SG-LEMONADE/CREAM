//
//  ProductUseCase.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import Foundation

protocol ProductUseCaseInterface {
    func fetch(page: Int,
               searchWord: String?,
               category: String?,
               sort: String?,
               brandId: String?,
               completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable
    func fetchItemById(_ id: Int, completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable
}

final class ProductUseCase {
    private let repository: ProductRepositoryInterface
    
    init(_ repository: ProductRepositoryInterface) {
        self.repository = repository
    }
}

extension ProductUseCase: ProductUseCaseInterface {
    
    // TODO: 목록 요청
    @discardableResult
    func fetch(page: Int,
               searchWord: String?,
               category: String?,
               sort: String?,
               brandId: String?,
               completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable {
        repository.requestProducts(page: page,
                                   searchWord: searchWord,
                                   category: category,
                                   sort: sort,
                                   brandId: brandId) { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
