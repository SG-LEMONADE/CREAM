//
//  ShopBannerCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/18.
//

import UIKit

class ShopBannerCell: UICollectionViewCell {
    
    var sessionTask: URLSessionDataTask?
    
    static let reuseIdentifier = "\(ShopBannerCell.self)"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        self.imageView.backgroundColor = nil
        self.sessionTask = nil
    }
}
// MARK: ViewConfiguration
extension ShopBannerCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Configure Cell
extension ShopBannerCell {
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
    
    func configure(_ image: String) {
        guard let url = URL(string: image) else { return }
        sessionTask = loadImage(url: url) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    func configureAds(_ image: String) {
        let image = UIImage(named: image)
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
