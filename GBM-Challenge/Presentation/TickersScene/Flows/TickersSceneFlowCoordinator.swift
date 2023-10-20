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
    func makeTickerDetailsViewController(symbol: String) -> UIViewController
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
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = TickersListViewModelActions(showTickersDetail: showTickerDetails)
        let vc = dependencies.makeTickersListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }

    private func showTickerDetails(symbol: String) {
        let vc = dependencies.makeTickerDetailsViewController(symbol: symbol)
        navigationController?.pushViewController(vc, animated: true)
    }
}
