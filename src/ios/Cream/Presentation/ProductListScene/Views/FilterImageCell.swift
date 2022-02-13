//
//  FilterHeaderCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

import UIKit

class FilterImageCell: UICollectionViewCell {
    static let reuseIdentifier = "\(FilterImageCell.self)"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemGray6
        layer.cornerRadius = frame.height / 4
    }
        
    func configure(_ image: String) {
        guard let image = UIImage(systemName: image) else { return }
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func resize(image: UIImage, scale: CGFloat, completionHandler: ((UIImage?) -> Void))
    {
        
       let transform = CGAffineTransform(scaleX: scale, y: scale)
       let size = image.size.applying(transform)
       UIGraphicsBeginImageContext(size)
       image.draw(in: CGRect(origin: .zero, size: size))
       let resultImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
       completionHandler(resultImage)
    }
}

extension FilterImageCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
