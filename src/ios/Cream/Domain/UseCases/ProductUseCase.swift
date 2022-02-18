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
               completion: @escaping ((Result<Products, Error>) -> Void))
    func fetchItemById(_ id: Int,
                       size: String?,
                       completion: @escaping ((Result<ProductDetail, Error>) -> Void))
    
    func addWishList(productId: Int,
                     size: String,
                     completion: @escaping (Result<Void, Error>) -> Void)
}

final class ProductUseCase {
    private let repository: ProductRepositoryInterface
    
    init(_ repository: ProductRepositoryInterface) {
        self.repository = repository
    }
}

extension ProductUseCase: ProductUseCaseInterface {
    func addWishList(productId: Int, size: String, completion: @escaping (Result<Void, Error>) -> Void) {
        _ = repository.addWishList(productId: productId, size: size) { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // TODO: 목록 요청
    
    func fetch(page: Int,
               searchWord: String?,
               category: String?,
               sort: String?,
               brandId: String?,
               completion: @escaping ((Result<Products, Error>) -> Void)) {
        _ = repository.requestProducts(page: page,
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
    
    
    func fetchItemById(_ id: Int,
                       size: String?,
                       completion: @escaping ((Result<ProductDetail, Error>) -> Void)) {
        _ = repository.requestProductById(id, size: size) { result in
            switch result {
            case .success(let product):
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
