//
//  ImageLoader.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/01.
//

import UIKit

protocol ImageLoadable {
    var session: URLSessionDataTask? { get set }
}


extension ImageLoadable {
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, Response, error in
            guard let data = data
            else { return }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
        
        return task
    }
}
