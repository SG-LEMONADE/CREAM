//
//  SizeButton.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/21.
//

import UIKit

final class SizeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRoundedBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setRoundedBorder()
    }
    
    private func setRoundedBorder() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width + contentEdgeInsets.left + contentEdgeInsets.right + titleEdgeInsets.left + titleEdgeInsets.right,
                      height: super.intrinsicContentSize.height + contentEdgeInsets.top + contentEdgeInsets.bottom + titleEdgeInsets.top
                        + titleEdgeInsets.bottom )
    }
}
