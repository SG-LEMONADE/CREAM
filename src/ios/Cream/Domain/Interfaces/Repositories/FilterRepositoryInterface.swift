//
//  FilterRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

protocol FilterRepositoryInterface {
    func fetchFilter(completion: @escaping ((Result<Filter, Error>) -> Void)) -> Cancellable
}
