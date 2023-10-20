//
//  DefaultTickersRepository.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation


final class DefaultTickersRepository {
    
    private let dataTranferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(
        dataTranferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTranferService = dataTranferService
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultTickersRepository: TickersRepository {
    
    func fetchTickers(completion: @escaping (Result<Tickers, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        guard !task.isCancelled else { return nil }
        
        let endpoint = APIEndpoints.getTickers()
        task.networkTask = self.dataTranferService.request(with: endpoint, 
                                                           on: backgroundQueue,
                                                           completion: { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
    }
}
