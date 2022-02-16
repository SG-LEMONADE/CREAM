//
//  WishCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/16.
//

import UIKit
import SnapKit

class WishCell: UICollectionViewCell {
    static let reuseIdentifier = "\(WishCell.self)"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                wishImageView.image = UIImage(named: "bookmark.fill")
            } else {
                wishImageView.image = UIImage(named: "bookmark")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var wishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmark")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sizeLabel, wishImageView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
}

extension WishCell: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(containerView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }
    
    func viewConfigure() {
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1
    }
}

extension WishCell {
    func configure(size: String, isSelected: Bool) {
        self.sizeLabel.text = size
        self.isSelected = isSelected
    }
}

