//
//  LoginViewModelSpec.swift
//  LoginViewModelSpec
//
//  Created by wankikim-MN on 2022/02/14.
//

import XCTest
@testable import Cream

class LoginViewModelSpec: XCTestCase {
    var viewModel: LoginViewModel!
    var mockUseCase: UserUseCaseInterface!
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
    }
    
    // MARK: Login 성공 케이스
    func testLoginWIthCorrectDataSetsSuccessPresentedToTrue() {
        // give
        mockUseCase = MockUserService(isSuccess: true)
        viewModel = .init(usecase: mockUseCase)
        let answer = true
        // when
        viewModel.confirmUser(email: "HI", password: "HI") { result in
            switch result {
            // then
            case .success(let data):
                XCTAssertEqual(data, answer)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    // MARK: Login 실패 케이스
    func testLoginWithFailDataSetsSuccessPresentedToTrue() {
        mockUseCase = MockUserService(isSuccess: false)
        viewModel = .init(usecase: mockUseCase)
        let answer: UserError = .authInvalid
        
        viewModel.confirmUser(email: "", password: "") { result in
            switch result {
            // then
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, answer)
            }
        }
    }
    
    // MARK: Email Input 유효값 성공 케이스
    func test_success_EmailIsValid() {
        mockUseCase = MockUserService()
        viewModel = .init(usecase: mockUseCase)
        
        let answer = ValidationHelper.State.valid
        
        let regEx = "wankikim@smilegate.com"
        viewModel.validateEmail(regEx)
        
        XCTAssertEqual(answer.description, viewModel.emailMessage.value)
    }
    // MARK: Email Input 유효값 실패 케이스
    func test_failure_EmailIsValid() {
        mockUseCase = MockUserService()
        viewModel = .init(usecase: mockUseCase)
        // give
        let answer = ValidationHelper.State.emailFormatInvalid
        // when
        let regEx = "wankiki@@@..com"
        viewModel.validateEmail(regEx)
        // then
        XCTAssertEqual(answer.description, viewModel.emailMessage.value)
    }
    // MARK: Password Input 유효값 성공 케이스
    func test_success_PasswordIsValid() {
        mockUseCase = MockUserService()
        viewModel = .init(usecase: mockUseCase)
        // give
        let answer = ValidationHelper.State.valid
        // when
        let regEx = "password1!"
        viewModel.validatePassword(regEx)
        // then
        XCTAssertEqual(answer.description, viewModel.passwordMessage.value)
    }
    // MARK: Password Input 유효값 실패 케이스
    func test_success_PasswordIsInValid() {
        mockUseCase = MockUserService()
        viewModel = .init(usecase: mockUseCase)
        // give
        let answer = ValidationHelper.State.passwordFormatInvalid
        // when
        let regEx = "123445"
        viewModel.validatePassword(regEx)
        // then
        XCTAssertEqual(answer.description, viewModel.passwordMessage.value)
    }
}
