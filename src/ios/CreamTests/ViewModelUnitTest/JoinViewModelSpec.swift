//
//  JoinViewModelSpec.swift
//  CreamTests
//
//  Created by wankikim-MN on 2022/02/14.
//

import XCTest
@testable import Cream

class JoinViewModelSpec: XCTestCase {
    var viewModel: JoinViewModel!
    var mockUseCase: UserUseCaseInterface!
    
    override func setUp() {
        mockUseCase = MockUserService(isSuccess: true)
        viewModel = .init(usecase: mockUseCase)
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
    }
    
    // MARK: 회원 가입 성공 케이스
    func test_success_joinToServer() {
        // give
        let input: User = .init(email: "email", name: nil, address: nil, gender: nil, age: nil, shoeSize: 250, profileImageUrl: "", lastLoginDateTime: nil)
        // when
        viewModel.addUser(email: input.email, password: "", shoesize: input.shoeSize) { result in
            switch result {
                // then
            case .success(let user):
                XCTAssertEqual(input, user)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    // MARK: 회원 가입 실패 케이스
    func test_failure_joinToServer() {
        mockUseCase = MockUserService(isSuccess: false)
        viewModel = .init(usecase: mockUseCase)
        // give
        let input: User = .init(email: "email", name: nil, address: nil, gender: nil, age: nil, shoeSize: 250, profileImageUrl: "", lastLoginDateTime: nil)
        // when
        viewModel.addUser(email: input.email, password: "", shoesize: input.shoeSize) { result in
            switch result {
                // then
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .userNotAccepted)
            }
        }
    }
    
    // MARK: Email Input 유효값 성공 케이스
    func test_success_EmailIsValid() {
        // give
        let answer = ValidationHelper.State.valid
        let validInput = "wankikim@smilegate.com"
        //when
        viewModel.validateEmail(validInput)
        //then
        XCTAssertEqual(answer.description, viewModel.emailMessage.value)
    }
    // MARK: Email Input 유효값 실패 케이스
    func test_failure_EmailIsInvalid() {
        mockUseCase = MockUserService()
        viewModel = .init(usecase: mockUseCase)
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
    func test_failure_PasswordIsInvalid() {
        // give
        let answer = ValidationHelper.State.passwordFormatInvalid
        let invalidInput = "123445"
        // when
        viewModel.validatePassword(invalidInput)
        // then
        XCTAssertEqual(answer.description, viewModel.passwordMessage.value)
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email && lhs.shoeSize == rhs.shoeSize
    }
}
