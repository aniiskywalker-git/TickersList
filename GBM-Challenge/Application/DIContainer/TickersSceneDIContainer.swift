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
    
    func makeTickerDetailUseCase() -> TickerDetailUseCase {
        DefaultTickerDetailUseCase(tickerDetailRepository: makeTickerDetailRepository())
    }
    
    // MARK: - Repositories
    func makeTickersListRepository() -> TickersRepository {
        DefaultTickersRepository(dataTranferService: dependencies.apiDataTransferService)
    }
    
    func makeTickerDetailRepository() -> TickerDetailRepository {
        DefaultTickerDetailRepository(dataTranferService: dependencies.apiDataTransferService)
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
    
    func makeTickerDetailsViewController(ticker: TickersListItemViewModel) -> UIViewController {
        TickerDetailsViewController.create(
            with: makeTickerDetailsViewModel(ticker: ticker)
        )
    }
    
    func makeTickerDetailsViewModel(ticker: TickersListItemViewModel) -> TickerDetailsViewModel {
        DefaultTickerDetailsViewModel(
            ticker: ticker, 
            tickerDetailUseCase: makeTickerDetailUseCase()
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
