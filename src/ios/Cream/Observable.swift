//
//  Observable.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/10.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> Void
    
    var listners: [Listener?] = []
    
    func bind(callback: @escaping (T) -> Void) {
        self.listners.append(callback)
    }
    
    var value: T {
        didSet {
            for listener in listners {
                listener?(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
