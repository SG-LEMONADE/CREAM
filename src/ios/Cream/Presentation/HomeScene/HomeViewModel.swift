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
}

protocol HomeViewModelOutput {
    var homeInfo: Observable<HomeInfo> { get set }
    var numberOfSections: Int { get }
}

protocol HomeViewModelInterface: HomeViewModelInput, HomeViewModelOutput { }

final class HomeViewModel: HomeViewModelInterface {
    var homeInfo: Observable<HomeInfo> = Observable(.init(ads: [], sections: []))
    var usecase: HomeListUseCaseInterface
    
    var numberOfSections: Int {
        return homeInfo.value.sections.count * 2
    }
    
    var numberOfItems: Int {
        homeInfo.value.sections[0].products.count
    }
    
    init(_ usecase: HomeListUseCaseInterface) {
        self.usecase = usecase
    }
    
    func viewDidLoad() {
        _ = usecase.fetchHome { result in
            switch result {
            case .success(let homeInfo):
                print(homeInfo)
                self.homeInfo.value = homeInfo
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapProduct(indexPath: IndexPath) {
        // TODO: CollectionView Click Event 발생 시
    }
}
