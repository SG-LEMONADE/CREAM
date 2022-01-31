//
//  SizeListView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/29.
//

import UIKit

class SizeListView: UIView {
    
    enum Constraint {
        private enum Inset {
            static let left: CGFloat = 2
            static let right: CGFloat = 2
            static let top: CGFloat = 2
            static let down: CGFloat = 2
        }
        static let itemSpace: CGFloat = 2
        static let lineSpace: CGFloat = 2
        
        static let GridWidthSpacing: CGFloat = itemSpace + Inset.left + Inset.right
        static let GridHeightSpacing: CGFloat = lineSpace + Inset.top + Inset.down
    }
    
    let maxDimmedAlpha: CGFloat = 0.4
    let defaultHeight: CGFloat = UIScreen.main.bounds.size.height * 0.6
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Container View inner
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사이즈 선택"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var bottomSheetNavigationStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, exitButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var sizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constraint.itemSpace
        layout.minimumLineSpacing = Constraint.lineSpace
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [bottomSheetNavigationStack, sizeCollectionView, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
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

extension SizeListView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(dimmedView, containerView)
        containerView.addSubviews(contentStackView)
    }
    
    func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(32)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-10)
            $0.leading.equalTo(containerView.snp.leading).offset(10)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func viewConfigure() {
        self.backgroundColor = .clear
    }
}
