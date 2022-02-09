//
//  SortFilterView.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/08.
//

import UIKit

protocol SortFilterFooterViewDelegate: AnyObject {
    func didTapSortButton()
}

final class SortFilterFooterView: UICollectionReusableView {
    static let reuseIdentifier = "\(SortFilterFooterView.self)"
    
    weak var delegate: SortFilterFooterViewDelegate?
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.imageView?.tintColor = .systemGray2
        button.setTitleColor(.black, for: .normal)
        button.setTitle("인기순", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    @objc
    func didTapSortButton() {
        delegate?.didTapSortButton()
    }
}

// MARK: - ViewConfiguration
extension SortFilterFooterView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(sortButton)
    }
    
    func setupConstraints() {
        sortButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        sortButton.imageView?.snp.makeConstraints {
            $0.height.equalTo(sortButton.titleLabel!.snp.height)
            $0.width.equalTo(sortButton.imageView!.snp.height)
        }
    }
    
    func viewConfigure() {
        backgroundColor = .white
        sortButton.layer.cornerRadius = 10
    }
}

// MARK: -
extension SortFilterFooterView: SortChangeDelegate {
    func didChangeStandard(to standard: String) {
        guard let standard = SortInfo(rawValue: standard)?.translatedString
        else { return }
        DispatchQueue.main.async { [weak self] in
            self?.sortButton.setTitle(standard, for: .normal)
        }
    }
}
