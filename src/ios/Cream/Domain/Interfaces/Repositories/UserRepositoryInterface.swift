//
//  UserRepositoryInterface.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import Foundation

protocol UserRepositoryInterface {
    func confirm(email: String,
                 password: String,
                 completion: @escaping (Result<Auth, Error>) -> Void) -> Cancellable
    func add(email: String,
             password: String,
             shoesize: Int,
             completion: @escaping (Result<User, Error>) -> Void) -> Cancellable
    
    func verifyToken(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable
    func reissueToken(completion: @escaping (Result<Auth, Error>) -> Void) -> Cancellable
}
