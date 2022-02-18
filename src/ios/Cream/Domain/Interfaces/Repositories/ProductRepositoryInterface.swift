//
//  ProductRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/25.
//

import Foundation

protocol ProductRepositoryInterface {
    func requestProducts(page: Int,
                         searchWord: String?,
                         category: String?,
                         sort: String?,
                         brandId: String?,
                         completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable
    func requestProductById(_ id: Int,
                            size: String?,
                            completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable
    
    func addWishList(productId: Int, size: String, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable
}
