//
//  UIStackView+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/30.
//

import UIKit

// MARK: - Add ArrangedSubviews
extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}

// MARK: - Add Separators between inner Views
extension UIStackView {
    func addSeparators(at positions: [Int], color: UIColor) {
        for position in positions {
            let separator = UIView()
            separator.backgroundColor = color
            insertArrangedSubview(separator, at: position)
            
            switch self.axis {
            case .horizontal:
                separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
                separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
            case .vertical:
                separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
                separator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            @unknown default:
                fatalError("Unknown UIStackView axis value.")
            }
            
        }
    }
}
