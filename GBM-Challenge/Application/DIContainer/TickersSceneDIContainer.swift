//
//  TickersSceneDIContainer.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import UIKit

final class TickersSceneDIContainer: TickersSceneFlowCoordinatorDependencies {
   
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeTickersListUseCase() -> TickersListUseCase {
        DefaultTickersListUseCase(tickersRepository: makeTickersListRepository())
    }
    
    // MARK: - Repositories
    func makeTickersListRepository() -> TickersRepository {
        DefaultTickersRepository(dataTranferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Tickers List
    func makeTickersListViewController(actions: TickersListViewModelActions) -> TickersViewController {
        TickersViewController.create(
            with: makeTickersListViewModel(actions: actions)
        )
    }
    
    func makeTickersListViewModel(actions: TickersListViewModelActions) -> DefaultTickersListViewModel {
        DefaultTickersListViewModel(tickersListUseCase: makeTickersListUseCase(), 
                                    actions: actions)
    }
    
    // MARK: - Ticker Details
    
    func makeTickerDetailsViewController(symbol: String) -> UIViewController {
        TickerDetailsViewController.create(
            with: makeTickerDetailsViewModel(symbol: symbol)
        )
    }
    
    func makeTickerDetailsViewModel(symbol: String) -> TickerDetailsViewModel {
        DefaultTickerDetailsViewModel(
            symbol: symbol
        )
    }

    // MARK: - Flow Coordinators
    func makeTickersFlowCoordinator(navigationController: UINavigationController) -> TickersSceneFlowCoordinator {
        TickersSceneFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
