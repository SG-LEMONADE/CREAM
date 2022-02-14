//
//  RepositoryTask.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/14.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
