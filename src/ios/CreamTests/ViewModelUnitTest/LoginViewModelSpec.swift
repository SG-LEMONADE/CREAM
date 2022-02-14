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
    
    override func setUp() {
        mockUseCase = MockUserService(isSuccess: true)
        viewModel = .init(usecase: mockUseCase)
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
    }
    
    // MARK: Login 성공 케이스
    func test_success_LoginWithCorrectData() {
        // give
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
    func test_failure_loginWithInCorrectData() {
        mockUseCase = MockUserService(isSuccess: false)
        viewModel = .init(usecase: mockUseCase)
        // give
        let answer: UserError = .authInvalid
        // when
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
        // give
        let answer = ValidationHelper.State.valid
        let validInput = "wankikim@smilegate.com"
        // when
        viewModel.validateEmail(validInput)
        // then
        XCTAssertEqual(answer.description, viewModel.emailMessage.value)
    }
    // MARK: Email Input 유효값 실패 케이스
    func test_failure_EmailIsValid() {
        // give
        let answer = ValidationHelper.State.emailFormatInvalid
        let invalidInput = "wankiki@@@..com"
        // when
        viewModel.validateEmail(invalidInput)
        // then
        XCTAssertEqual(answer.description, viewModel.emailMessage.value)
    }
    // MARK: Password Input 유효값 성공 케이스
    func test_success_PasswordIsValid() {
        // give
        let answer = ValidationHelper.State.valid
        let validInput = "password1!"
        // when
        viewModel.validatePassword(validInput)
        // then
        XCTAssertEqual(answer.description, viewModel.passwordMessage.value)
    }
    // MARK: Password Input 유효값 실패 케이스
    func test_failure_PasswordIsInValid() {
        // give
        let answer = ValidationHelper.State.passwordFormatInvalid
        let invalidInput = "123445"
        // when
        viewModel.validatePassword(invalidInput)
        // then
        XCTAssertEqual(answer.description, viewModel.passwordMessage.value)
    }
}
