//
//  Integrator.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/10.
//

import Foundation
import SwiftKeychainWrapper

protocol Integratorable {
    func didFinishLaunching(withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

class Integrator: NSObject {
    static let shared = Integrator()
    
    private var integrators: [Integratorable] = []
    private let authIntegrator: AuthIntegrator = AuthIntegrator()
    
    private override init() {
        super.init()
        integrators = [authIntegrator]
    }
    
    static var gateWayURL: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "API-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'API-Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "GateWay") as? String else {
                fatalError("Couldn't find key 'GateWay' in 'API-Info.plist'.")
            }
            return value
        }
    }    
}

extension Integrator: Integratorable {
    func didFinishLaunching(withOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        integrators.forEach { $0.didFinishLaunching(withOptions: launchOptions) }
    }
}

class AuthIntegrator: Integratorable {
    private let usecase: UserUseCaseInterface = AuthIntegrator.configureAuthInfoTransferService()
    
    func didFinishLaunching(withOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        verifyToken()
    }
    
    private func verifyToken() {
        usecase.verifyToken { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.updateToken()
            }
        }
    }
    
    private func updateToken() {
        usecase.reissuanceToken { result in
            switch result {
            case .success(let auth):
                KeychainWrapper.standard.set(auth.accessToken, forKey: KeychainWrapper.Key.accessToken)
                KeychainWrapper.standard.set(auth.refreshToken, forKey: KeychainWrapper.Key.refreshToken)
            case .failure(_):
                KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.accessToken)
                KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.refreshToken)
            }
        }
    }
    
    private static func configureAuthInfoTransferService() -> UserUseCaseInterface {
        guard let baseURL = URL(string: Integrator.gateWayURL)
        else { fatalError() }

        let config: NetworkConfigurable = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService: NetworkService = DefaultNetworkService(config: config)
        let dataTransferService: DataTransferService = DefaultDataTransferService(with: networkService)
        let repository: UserRepositoryInterface = UserRepository(dataTransferService: dataTransferService)
        let usecase: UserUseCaseInterface = UserUseCase(repository)
        return usecase
    }
}
