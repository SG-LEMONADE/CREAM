//
//  SettingViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/12.
//

import Foundation
import SwiftKeychainWrapper

protocol SettingViewModelInput {
    func didTapLogoutButton(completion: @escaping (Result<Void, Error>) -> Void)
}
protocol SettingViewModelOutput {
    var numberOfSections: Int { get }
    var sectionTitles: [String] { get set }
    var sectionInfo: [[String]] { get set }
}
protocol SettingViewModel: SettingViewModelInput, SettingViewModelOutput { }

final class DefaultSettingViewModel: SettingViewModel {
    var sectionTitles: [String] = ["일반", "정보"]
    var sectionInfo: [[String]] = [["로그인 정보", "주소록"], ["로그아웃"]]
    let usecase: UserUseCaseInterface
    
    init(_ usecase: UserUseCaseInterface) {
        self.usecase = usecase
    }
    var numberOfSections: Int {
        return 2
    }
    
    func didTapLogoutButton(completion: @escaping (Result<Void, Error>) -> Void) {
        usecase.removeToken { result in
            switch result {
            case .success(let void):
                KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.accessToken)
                KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.refreshToken)
                completion(.success(void))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

