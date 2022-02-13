//
//  Filter.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/13.
//

import Foundation

struct Filter {
    let categories: [String]
    let brands: [Brand]
    let collections: [String]
    let gender: [String]
}

struct Brand {
    let id: Int
    let name: String
    let logoImageUrl: String?
}
