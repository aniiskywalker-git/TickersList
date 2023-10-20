//
//  AppDIContainer.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            queryParameters: [
                "access_key": appConfiguration.apiKey
            ]
        )
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    func makeTickersSceneDIContainer() -> TickersSceneDIContainer {
        let dependencies = TickersSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService
        )
        return TickersSceneDIContainer(dependencies: dependencies)
    }
}
