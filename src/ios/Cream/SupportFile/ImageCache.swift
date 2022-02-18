//
//  ImageCache.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/17.
//

import UIKit

let imageCache = ImageCache()

class ImageCache: NSCache<AnyObject, AnyObject> {
    func add(_ image: UIImage, forKey key: String) {
        setObject(image, forKey: key as AnyObject)
    }
    
    func image(forKey key: String) -> UIImage? {
        guard let image = object(forKey: key as AnyObject) as AnyObject as? UIImage
        else { return nil }
        
        return image
    }    
}
