//
//  MyPageViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/11.
//

import Foundation

protocol MyPageViewModelInput {
    func viewDidLoad()
}
protocol MyPageViewModelOutput {
    var userInfo: Observable<User> { get set }
    var numberOfSections: Int { get }
}
protocol MyPageViewModelInterface: MyPageViewModelInput, MyPageViewModelOutput { }

final class MyPageViewModel: MyPageViewModelInterface {
    private let usecase: MyPageUseCaseInterface
    var userInfo: Observable<User> = Observable(User(email: "", name: "", address: "", gender: 1,
                                                     age: "", shoeSize: 0, profileImageUrl: "", lastLoginDateTime: ""))
    var numberOfSections: Int { return 3 }
    
    init(_ usecase: MyPageUseCaseInterface) {
        self.usecase = usecase
    }
    
    // TODO: API call 이후, UITableView 그리기 -> Model에 Data 전달 API 모든 결과가 도착하고, 화면 그리기
    func viewDidLoad() {
        usecase.fetchUserInfo { result in
        }
        usecase.fetchTradeInfo(tradeType: .buy) { result in
        }
        usecase.fetchTradeInfo(tradeType: .sell) { result in
        }
    }
}
