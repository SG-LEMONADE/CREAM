//
//  ManagementViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/21.
//

import Foundation

protocol ManagementViewModelInput {
    func viewDidLoad()
    func didTapBidView()
    func didTapProgressView()
    func didTapCompleteView()
}

protocol ManagementViewModelOutput {
    var selectedList: Observable<[Trade]> { get set }
    var totalList: Observable<TradeList> { get set }
    var numberOfRows: Int { get }
    var tradeType: TradeType { get }
}

protocol ManagementViewModelInterface: ManagementViewModelInput, ManagementViewModelOutput { }

final class ManagementViewModel: ManagementViewModelInterface {
    private let usecase: MyPageUseCaseInterface
    private var tradeState: TradeStatus
    
    let tradeType: TradeType
    var totalList: Observable<TradeList> = .init(TradeList(counter: .init(totalCnt: 0, waitingCnt: 0, inProgressCnt: 0, finishedCnt: 0), trades: []))
    var selectedList: Observable<[Trade]> = .init([])
    var error: Observable<UserError> = .init(.authInvalid)
    var numberOfRows: Int {
        return selectedList.value.count
    }
    
    init(usecase: MyPageUseCaseInterface, tradeType: TradeType, tradeState: TradeStatus) {
        self.usecase = usecase
        self.tradeType = tradeType
        self.tradeState = tradeState
    }
    
    func viewDidLoad() {
        usecase.fetchTradeInfo(tradeType: tradeType) { [weak self] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let list):
                self.totalList.value = list
                self.selectedList.value = self.totalList.value.trades.filter { $0.tradeStatus == self.tradeState.desctiprion }
                
            case .failure(let error):
                self.error.value = error
                print(error)
            }
        }
    }
    
    func didTapBidView() {
        self.selectedList.value = self.totalList.value.trades.filter { $0.tradeStatus == TradeStatus.waiting.desctiprion }
    }
        
    func didTapProgressView() {
        self.selectedList.value = self.totalList.value.trades.filter { $0.tradeStatus == TradeStatus.inProgress.desctiprion }
    }
    
    func didTapCompleteView() {
        self.selectedList.value = self.totalList.value.trades.filter { $0.tradeStatus == TradeStatus.finished.desctiprion }
    }
}

