//
//  UISegmentedControl+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/15.
//

import UIKit

extension UISegmentedControl {
    func defaultConfiguration(font: UIFont = .systemFont(ofSize: 15),
                              color: UIColor = .systemGray3) {
        let defaultAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }

    func selectedConfiguration(font: UIFont = .boldSystemFont(ofSize: 15),
                               color: UIColor = .white)
    {
        let selectedAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
