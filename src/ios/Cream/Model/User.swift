//
//  User.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import Foundation

struct User {
    private var email: Observable<String> = Observable("")
    private var password: Observable<String> = Observable("")
}