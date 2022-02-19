//
//  HomeViewModel.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/19.
//

import Foundation

protocol HomeViewModelInput {
    func viewDidLoad()
    func didTapProduct(indexPath: IndexPath)
    func removeFromWishList(size: String)
    func addToWishList(size: String)
    func didTapWishButton(id: Int)
}

protocol HomeViewModelOutput {
    var homeInfo: Observable<HomeInfo> { get set }
    var numberOfSections: Int { get }
    var isLoaded: Bool { get set }
}

protocol HomeViewModelInterface: HomeViewModelInput, HomeViewModelOutput { }

final class HomeViewModel: HomeViewModelInterface {
    var homeInfo: Observable<HomeInfo> = Observable(.init(ads: [], sections: []))
    private let homeUseCase: HomeListUseCaseInterface
    private let productUseCase: ProductUseCaseInterface
    
    var isLoaded: Bool = true
    var currentWishItem: Int? = nil
    var numberOfSections: Int {
        return homeInfo.value.sections.count * 2
    }
    
    var numberOfItems: Int {
        homeInfo.value.sections[0].products.count
    }
    
    init(_ homeUseCase: HomeListUseCaseInterface, _ productUseCase: ProductUseCaseInterface) {
        self.homeUseCase = homeUseCase
        self.productUseCase = productUseCase
    }
    
    func viewDidLoad() {
        _ = homeUseCase.fetchHome { result in
            switch result {
            case .success(let homeInfo):
                self.homeInfo.value = homeInfo
            case .failure(let error):
                print(error)
            }
        }
    }
    func didTapWishButton(id: Int) {
        currentWishItem = id
    }
    
    func didTapProduct(indexPath: IndexPath) {
        // TODO: CollectionView Click Event 발생 시
    }
    
    func removeFromWishList(size: String) {
        guard let currentWishItem = currentWishItem
        else { return }

        productUseCase.addWishList(productId: currentWishItem, size: size) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
            }
        }
    }

    func addToWishList(size: String) {
        guard let currentWishItem = currentWishItem
        else { return }

        productUseCase.addWishList(productId: currentWishItem, size: size) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
