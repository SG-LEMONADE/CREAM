//
//  ProductRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/25.
//

import Foundation

protocol ProductRepositoryInterface {
    func fetchHome(completion: @escaping ((Result<HomeData, Error>) -> Void)) -> Cancellable
    func requestProducts(page: Int,
                         category: String?,
                         completion: @escaping ((Result<Products, Error>) -> Void)) -> Cancellable
    func requestProductById(_ id: Int,
                            completion: @escaping ((Result<ProductDetail, Error>) -> Void)) -> Cancellable
}
