//
//  AppFlowCoordinator.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let tickersSceneDIContainer = appDIContainer.makeTickersSceneDIContainer()
        let flow = tickersSceneDIContainer.makeTickersFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
