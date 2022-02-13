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
    
    var userInfo: Observable<User> = Observable(User(email: "", name: "", address: "", gender: 1, age: "", shoeSize: 280, profileImageUrl: "", lastLoginDateTime: " "))
    var numberOfSections: Int { return 3 }
    
    func viewDidLoad() {
        
    }
}
