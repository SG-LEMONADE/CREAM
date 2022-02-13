//
//  MyInfoCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/11.
//

import UIKit
import SnapKit

protocol ProfileReviseDelegate: AnyObject {
    func moveToProfileScene()
}

class MyInfoCell: UITableViewCell {
    static let reuseIdentifier: String = "\(MyInfoCell.self)"
    
    weak var delegate: ProfileReviseDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.clipsToBounds = true
        imageView.tintColor = .gray
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "profileName"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var reviseProfileButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    @objc
    func didTapReviseButton() {
        delegate?.moveToProfileScene()
    }
}

extension MyInfoCell {
    func configureTest() {
        profileImageView.image = UIImage(systemName: "person.fill")
        nameLabel.text = "nameLabel"
        profileNameLabel.text = "profileNameLabel"
        reviseProfileButton.setTitle("프로필 편집", for: .normal)
    }
}

extension MyInfoCell: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubviews(profileImageView,
                                nameLabel,
                                profileNameLabel,
                                reviseProfileButton)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.bottom.equalTo(nameLabel.snp.top).offset(-10)
            $0.trailing.equalTo(profileNameLabel.snp.leading).offset(-10)
            $0.leading.equalTo(nameLabel.snp.leading).offset(-10)
            $0.width.height.equalTo(contentView.snp.width).multipliedBy(0.25).priority(999)
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(reviseProfileButton.snp.top).offset(-10)
        }
        
        reviseProfileButton.snp.makeConstraints {
            $0.leading.equalTo(profileNameLabel.snp.leading)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.centerY.equalToSuperview()
        }
        
//        contentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    func viewConfigure() {
        selectionStyle = .none
        reviseProfileButton.addTarget(self,
                                      action: #selector(didTapReviseButton),
                                      for: .touchUpInside)
    }
}
