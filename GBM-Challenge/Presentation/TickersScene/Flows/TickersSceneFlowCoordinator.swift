//
//  TickersSceneFlowCoordinator.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import UIKit

protocol TickersSceneFlowCoordinatorDependencies  {
    func makeTickersListViewController(
        actions: TickersListViewModelActions
    ) -> TickersViewController
    func makeTickerDetailsViewController(ticker: TickersListItemViewModel) -> UIViewController
}

final class TickersSceneFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: TickersSceneFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: TickersSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = TickersListViewModelActions(showTickersDetail: showTickerDetails)
        let vc = dependencies.makeTickersListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }

    private func showTickerDetails(ticker: TickersListItemViewModel) {
        let vc = dependencies.makeTickerDetailsViewController(ticker: ticker)
        navigationController?.pushViewController(vc, animated: true)
    }
}
