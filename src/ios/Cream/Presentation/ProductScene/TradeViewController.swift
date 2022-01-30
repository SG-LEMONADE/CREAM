//
//  TradeViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/23.
//

import UIKit
import SnapKit

class TradeViewModel {
    // 상품 사진
    // 모델정보
    // 상품명
    // 번역 상품명
    // 사이즈 정보
    
    private var sizeInfo: [Int]
    
    var numberOfCells: Int {
        return sizeInfo.count
    }
    
    init(_ sizeInfo: [Int]) {
        self.sizeInfo = sizeInfo
    }
}

class TradeViewController: UIViewController {

    private var viewModel: SizeListViewModel?
    
    init (_ viewModel: SizeListViewModel = DefaultSizeListViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var modelImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor.systemGray6
        return imageView
    }()
    
    private lazy var itemNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var itemTranslatedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemNumberLabel, itemTitleLabel, itemTranslatedLabel])
        stackView.axis = .vertical

        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [modelImageView, labelStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var sizeListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = Constraint.itemSpace
        layout.minimumLineSpacing = Constraint.lineSpace
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
        configure()
        sizeListView.dataSource = self
        sizeListView.delegate = self
        sizeListView.register(SizeListCell.self, forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
    }
    
    func configure(_ viewModel: ItemInfoViewModel? = nil) {
        self.modelImageView.image = UIImage(named: "mock_shoe1")
        self.itemTitleLabel.text = "아이템 라벨입니다."
        self.itemNumberLabel.text = "상품번호 라벨입니다."
        self.itemTranslatedLabel.text = "아이템에 대해 번역한 라벨입니다."
    }
}

final class ItemInfoViewModel {
    
}

extension TradeViewController: ViewConfiguration {
    func buildHierarchy() {
        self.view.addSubviews(containerStackView, sizeListView)
    }
    func setupConstraints() {
        modelImageView.snp.makeConstraints {
            $0.width.equalTo(self.view.snp.width).multipliedBy(0.25)
            $0.width.equalTo(self.modelImageView.snp.height)
            $0.leading.equalTo(containerStackView.snp.leading).inset(10)
            $0.height.greaterThanOrEqualTo(labelStackView.snp.height)
            $0.trailing.equalTo(labelStackView.snp.leading).offset(-10)
            $0.bottom.equalTo(containerStackView.snp.bottom).inset(10)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.top).inset(10)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(sizeListView.snp.top)
        }
        
        sizeListView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).inset(10)
            $0.trailing.equalTo(self.view.snp.trailing).inset(10)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

// MARK: CollectionView Layout & CollectionView Cell Configuration
extension TradeViewController: UICollectionViewDelegateFlowLayout {
    private enum Constraint {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellLayout = CGSize(width: (collectionView.bounds.size.width - 1 * Constraint.GridWidthSpacing) / 2, height: ((collectionView.bounds.size.width - Constraint.GridHeightSpacing) / 2) * 0.25)
        return cellLayout
    }
}

extension TradeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier, for: indexPath) as? SizeListCell else { return UICollectionViewCell() }
        
        viewModel?.getCellViewModel(at: indexPath) {
            cell.configure(with: $0)
        }
        
        return cell
    }
}
