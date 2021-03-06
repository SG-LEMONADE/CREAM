//
//  HomeListRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/07.
//

import Foundation

protocol HomeListRepositoryInterface {
    func fetchHome(completion: @escaping ((Result<HomeInfo, Error>) -> Void)) -> Cancellable
}
