//
//  VerticalButton.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/20.
//

import UIKit

final class VerticalButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentHorizontalAlignment = .left
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerButtonImageAndTitle()
    }
    
    private func centerButtonImageAndTitle() {
        let titleSize = self.titleLabel?.frame.size ?? .zero
        let imageSize = self.imageView?.frame.size ?? .zero
        let spacing: CGFloat = 6.0
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),left: 0, bottom: 0, right:  -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
    }
}
