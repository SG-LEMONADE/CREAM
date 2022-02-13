//
//  CompanyInfoCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/11.
//

import UIKit
import SnapKit

class CompanyInfoCell: UITableViewCell {
    static let reuseIdentifier: String = "\(CompanyInfoCell.self)"
    
    enum Constraint {
        static let fontSize: CGFloat = 12
    }
    
    var noticeButtonAction: (() -> Void)?
    var standardButtonAction: (() -> Void)?
    var penaltyButtonAction: (() -> Void)?
    var policyButtonAction: (() -> Void)?
    var showRoomButtonAction: (() -> Void)?
    var offlineCSButtonAction: (() -> Void)?
    
    private lazy var noticeButton: UIButton = {
        let button = UIButton()
        button.setTitle("공지사항", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constraint.fontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var standardButton: UIButton = {
        let button = UIButton()
        button.setTitle("검수 기준", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constraint.fontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var penaltyButton: UIButton = {
        let button = UIButton()
        button.setTitle("패널티 정책", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constraint.fontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var policyButton: UIButton = {
        let button = UIButton()
        button.setTitle("이용 정책", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constraint.fontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var showRoomButton: UIButton = {
        let button = UIButton()
        button.setTitle("쇼룸 안내", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constraint.fontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var offlineCSButton: UIButton = {
        let button = UIButton()
        button.setTitle("판매자 방문접수", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constraint.fontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noticeButton,
                                                       standardButton,
                                                       penaltyButton])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [policyButton,
                                                       showRoomButton,
                                                       offlineCSButton])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView,
                                                       bottomStackView])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = .flexibleHeight
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserAction() {
        noticeButton.addTarget(self, action: #selector(didTapNoticeButton), for: .touchUpInside)
        standardButton.addTarget(self, action: #selector(didTapStandardButton), for: .touchUpInside)
        penaltyButton.addTarget(self, action: #selector(didTapPenaltyButton), for: .touchUpInside)
        policyButton.addTarget(self, action: #selector(didTapPolicyButton), for: .touchUpInside)
        showRoomButton.addTarget(self, action: #selector(didTapShowRoomButton), for: .touchUpInside)
        offlineCSButton.addTarget(self, action: #selector(didTapOfflineCSButton), for: .touchUpInside)
    }
}

extension CompanyInfoCell: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubviews(containerStackView)
    }
    
    func setupConstraints() {
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(containerStackView.snp.width).multipliedBy(0.3).priority(999)
        }
    }
    
    func viewConfigure() {
        backgroundColor = .systemGroupedBackground
        selectionStyle = .none
        setupUserAction()
        
    }
}

extension CompanyInfoCell {
    @objc
    func didTapNoticeButton() {
        noticeButtonAction?()
    }
    
    @objc
    func didTapStandardButton() {
        standardButtonAction?()
    }
    
    @objc
    func didTapPenaltyButton() {
        penaltyButtonAction?()
    }
    
    @objc
    func didTapPolicyButton() {
        policyButtonAction?()
    }
    
    @objc
    func didTapShowRoomButton() {
        showRoomButtonAction?()
    }
    
    @objc
    func didTapOfflineCSButton() {
        offlineCSButtonAction?()
    }
}
