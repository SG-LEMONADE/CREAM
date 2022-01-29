//
//  ProductRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/25.
//

import Foundation

protocol ProductRepositoryInterface {
    func fetch(completion: @escaping ((Result<HomeData, Error>) -> Void)) -> Cancellable
}
