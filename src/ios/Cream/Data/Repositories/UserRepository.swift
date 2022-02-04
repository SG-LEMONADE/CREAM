//
//  UserRepository.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/28.
//

import Foundation

final class UserRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension UserRepository: UserRepositoryInterface {
    func confirm(email: String,
                 password: String,
                 completion: @escaping (Result<Auth, Error>) -> Void) -> Cancellable {
        let endpoint = APIEndpoints.confirmUser(with: AuthRequestDTO(email: email,
                                                                 password: password))
        
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
    
    func add(email: String,
             password: String,
             shoesize: Int,
             completion: @escaping (Result<User, Error>) -> Void) -> Cancellable {
        let endpoint = APIEndpoints.addUser(with: JoinRequestDTO(email: email,
                                                                 password: password,
                                                                 shoesize: shoesize))
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