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
    var isFinished: Observable<Bool> { get set }
    var userInfo: User { get set }
    var numberOfSections: Int { get }
    var askList: TradeList { get set }
    var bidList: TradeList { get set }
    var usecase: MyPageUseCaseInterface { get }
}

protocol MyPageViewModelInterface: MyPageViewModelInput, MyPageViewModelOutput { }

final class MyPageViewModel: MyPageViewModelInterface {
    var usecase: MyPageUseCaseInterface
    
    var isFinished: Observable<Bool> = Observable(false)
    var numberOfSections: Int { return 3 }
    var userInfo: User = User(email: "", name: "", address: "", gender: 1,
                                                     age: "", shoeSize: 0, profileImageUrl: "", lastLoginDateTime: "")
    
    var askList: TradeList = TradeList(counter: .init(totalCnt: 0, waitingCnt: 0, inProgressCnt: 0, finishedCnt: 0), trades: [])
    var bidList: TradeList = TradeList(counter: .init(totalCnt: 0, waitingCnt: 0, inProgressCnt: 0, finishedCnt: 0), trades: [])
    
    
    init(_ usecase: MyPageUseCaseInterface) {
        self.usecase = usecase
    }
    
    // TODO: API call 이후, UITableView 그리기 -> Model에 Data 전달 API 모든 결과가 도착하고, 화면 그리기
    func viewDidLoad() {
        let group = DispatchGroup.init()
        
        group.enter()
        DispatchQueue.global().async { [weak self] in
            self?.usecase.fetchTradeInfo(tradeType: .buy) { result in
                switch result {
                case .success(let askList):
                    self?.askList = askList
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async { [weak self] in
            self?.usecase.fetchTradeInfo(tradeType: .sell) { result in
                switch result {
                case .success(let bidList):
                    self?.bidList = bidList
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async { [weak self] in
            self?.usecase.fetchUserInfo { result in
                switch result {
                case .success(let user):
                    self?.userInfo = user
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        
        group.notify(queue: DispatchQueue.global()) { [weak self] in
            self?.isFinished.value = true
        }
    }
}
