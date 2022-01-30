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
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width + contentEdgeInsets.left + contentEdgeInsets.right + titleEdgeInsets.left + titleEdgeInsets.right,
                      height: super.intrinsicContentSize.height + contentEdgeInsets.top + contentEdgeInsets.bottom + titleEdgeInsets.top
                        + titleEdgeInsets.bottom )
    }
}

extension SizeButton: ViewConfiguration {
    func buildHierarchy() { }
    
    func setupConstraints() {
        self.imageView?.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func viewConfigure() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
}
