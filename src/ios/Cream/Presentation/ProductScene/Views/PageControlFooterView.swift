//
//  PageControlFooterView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/21.
//

import UIKit
import SnapKit

class PageControlFooterView: UICollectionReusableView {
    static let reuseIdentifier = "\(PageControlFooterView.self)"
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

extension PageControlFooterView {
    func configure(_ numberOfPages: Int) {
        if numberOfPages == 1 {
            pageControl.isHidden = true
        } else {
            pageControl.isHidden = false
        }
        self.pageControl.numberOfPages = numberOfPages
    }
    
}

// MARK: - ViewConfiguration
extension PageControlFooterView: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(pageControl)
    }
    
    func setupConstraints() {
        pageControl.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}


extension PageControlFooterView: FooterScrollDelegate {
    func didScrollTo(_ page: Int) {
        DispatchQueue.main.async {
            self.pageControl.currentPage = page
        }
    }
}
