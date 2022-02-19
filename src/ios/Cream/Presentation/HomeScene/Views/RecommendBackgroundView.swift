//
//  RecommendBackgroundView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/19.
//

import UIKit
import SnapKit

final class RecommendBackgroundView: UICollectionReusableView {
    static let reuseIdentifer = "\(RecommendBackgroundView.self)"
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "추천 서비스를 받기 위해서는 로그인이 필요해요!\n 로그인 후 서비스 이용 부탁드려요"
        return label
    }()
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendBackgroundView: ViewConfiguration {
    func buildHierarchy() {
        insetView.addSubviews(descriptionLabel)
        addSubviews(insetView)
    }
    
    func setupConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        insetView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func viewConfigure() {
        backgroundColor = .clear
    }
}
