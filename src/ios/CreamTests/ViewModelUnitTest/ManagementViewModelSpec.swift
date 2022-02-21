//
//  ManagementViewModelSpec.swift
//  CreamTests
//
//  Created by wankikim-MN on 2022/02/21.
//

import XCTest
@testable import Cream

class ManagementViewModelSpec: XCTestCase {
    var viewModel: ManagementViewModel!
    var mockMypageUsecase: MyPageUseCaseInterface!
    
    override func setUp() {
        mockMypageUsecase = MockMyPageUsecase(isSuccess: true)
        viewModel = .init(usecase: mockMypageUsecase,
                          tradeType: .buy, tradeState: .ask)
    }
    
    override func tearDown() {
        mockMypageUsecase = nil
        viewModel = nil
    }
    
    // 실제 성공도 했고, 데이터도 제대로 옴.
    func test_success_viewDidLoad() {
        // give
        let answer = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: [.init(id: 0, productId: 0,name: "name", size: "size", imageUrl: [], backgroundColor: "backgroundColor", tradeStatus: "tradeStatus", price: 0, updateDateTime: nil, validationDate: "")])
        // when
        viewModel.viewDidLoad()
        
        // then
        XCTAssertEqual(viewModel.totalList.value, answer)
    }
    
    
    func test_failure_viewDidLoad() {
        //give
        mockMypageUsecase = MockMyPageUsecase(isSuccess: false)
        viewModel = .init(usecase: mockMypageUsecase,
                          tradeType: .buy, tradeState: .ask)
        
        // when
        viewModel.viewDidLoad()
        
        // then
        XCTAssertEqual(viewModel.error.value, UserError.authInvalid)
    }
    
    func test_success_didTapBidView() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        let dummyInputs = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: dummyTrades)
        
        viewModel.totalList.value = dummyInputs
        // when
        viewModel.didTapBidView()
        
        // then
        XCTAssertEqual(viewModel.selectedList.value.count, 3)
    }
    
    func test_failure_didTapBidView() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        let dummyInputs = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: dummyTrades)
        
        viewModel.totalList.value = dummyInputs
        // when
        viewModel.didTapBidView()
        
        // then
        XCTAssertNotEqual(viewModel.selectedList.value.count, 2)
    }
    
    func test_success_didTapProgressView() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        let dummyInputs = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: dummyTrades)
        
        viewModel.totalList.value = dummyInputs
        // when
        viewModel.didTapProgressView()
        
        // then
        XCTAssertEqual(viewModel.selectedList.value.count, 0)
    }
    
    func test_failure_didTapProgressView() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        let dummyInputs = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: dummyTrades)
        
        viewModel.totalList.value = dummyInputs
        // when
        viewModel.didTapProgressView()
        
        // then
        XCTAssertNotEqual(viewModel.selectedList.value.count, 1)
    }
    
    func test_success_didTapCompleteView() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        let dummyInputs = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: dummyTrades)
        
        viewModel.totalList.value = dummyInputs
        // when
        viewModel.didTapCompleteView()
        
        // then
        XCTAssertEqual(viewModel.selectedList.value.count, 2)
    }
    
    func test_failure_didTapCompleteView() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                           Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                                 tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        let dummyInputs = TradeList(counter: .init(totalCnt: 1, waitingCnt: 1, inProgressCnt: 0, finishedCnt: 0), trades: dummyTrades)
        
        viewModel.totalList.value = dummyInputs
        // when
        viewModel.didTapCompleteView()
        
        // then
        XCTAssertNotEqual(viewModel.selectedList.value.count, 3)
    }
    
    func test_success_deleteTrade() {
        // give
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        viewModel.selectedList.value = dummyTrades
        let indexPath: IndexPath = .init(row: 0, section: 0)
        let answer = 4
        
        // when
        viewModel.deleteTrade(at: indexPath)
        // then
        XCTAssertEqual(viewModel.selectedList.value.count, answer)
    }
    
    func test_failure_deleteTrade() {
        // give
        mockMypageUsecase = MockMyPageUsecase(isSuccess: false)
        viewModel = .init(usecase: mockMypageUsecase,
                          tradeType: .buy, tradeState: .ask)
        
        let dummyTrades = [Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.waiting.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: ""),
                         Trade(id: 0, productId: 0, name: "1", size: "", imageUrl: [], backgroundColor: "",
                               tradeStatus: TradeStatus.finished.desctiprion, price: 0, updateDateTime: nil, validationDate: "")]
        viewModel.selectedList.value = dummyTrades
        let indexPath: IndexPath = .init(row: 0, section: 0)
        let answer = 4
        // when
        viewModel.deleteTrade(at: indexPath)
        
        // then
        XCTAssertNotEqual(viewModel.selectedList.value.count, answer)
    }
}

extension TradeList: Equatable {
    static public func == (lhs: TradeList, rhs: TradeList) -> Bool {
        return lhs.counter.totalCnt == rhs.counter.totalCnt &&
        lhs.counter.finishedCnt == rhs.counter.finishedCnt &&
        lhs.counter.inProgressCnt == rhs.counter.inProgressCnt &&
        lhs.counter.waitingCnt == rhs.counter.waitingCnt &&
        lhs.trades.first?.name == rhs.trades.first?.name
    }
}
