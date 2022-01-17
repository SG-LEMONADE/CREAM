//
//  SizeListViewController.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/13.
//

import UIKit

protocol SizeCatchable: NSObject {
    func configureShoesSize(_ size: Int)
}

final class SizeListViewController: UIViewController {
    private let maxDimmedAlpha: CGFloat = 0.4
    
    weak var delegate: SizeCatchable?
    private var viewModel = SizeListViewModel()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Container View inner
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사이즈 선택"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("❌", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(animateDismissView), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomSheetNavigationStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, exitButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var sizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = Constraint.itemSpace
        layout.minimumLineSpacing = Constraint.lineSpace
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [bottomSheetNavigationStack, sizeCollectionView, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    let defaultHeight: CGFloat = UIScreen.main.bounds.size.height * 0.6
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        sizeCollectionView.register(SizeListCell.self, forCellWithReuseIdentifier: SizeListCell.reuseIdentifier)
        setupView()
        setupConstraints()
        bindViewModel()
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        view.addSubviews(dimmedView, containerView)
        containerView.addSubviews(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        exitButton.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    @objc func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
    
    func bindViewModel() {
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.sizeCollectionView.reloadData()
            }
        }
    }
}

// MARK: CollectionView Layout & CollectionView Cell Configuration
extension SizeListViewController: UICollectionViewDelegateFlowLayout {
    
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
        let cellLayout = CGSize(width: (collectionView.bounds.size.width - 2 * Constraint.GridWidthSpacing) / 3, height: ((collectionView.bounds.size.width - Constraint.GridHeightSpacing) / 3) * 0.35)
        return cellLayout
    }
}

extension SizeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeListCell.reuseIdentifier,
                                                            for: indexPath) as? SizeListCell
        else { return UICollectionViewCell() }
        
        viewModel.getCellViewModel(at: indexPath) {
            cell.configure(with: $0)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.userPressed(at: indexPath) { [weak self] size in
            guard let self = self
            else { return }
            self.delegate?.configureShoesSize(size)
            UIView.animate(withDuration: 0.3) {
                self.containerViewBottomConstraint?.constant = self.defaultHeight
                self.view.layoutIfNeeded()
            }
            
            self.dimmedView.alpha = self.maxDimmedAlpha
            UIView.animate(withDuration: 0.3) {
                self.dimmedView.alpha = 0
            } completion: { _ in
                self.dismiss(animated: true)
            }
        }
        
    }
}
