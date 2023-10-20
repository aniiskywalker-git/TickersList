//
//  DefaultTickerDetailRepository.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

final class DefaultTickerDetailRepository {
    
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

extension DefaultTickerDetailRepository: TickerDetailRepository {

    func fetchTickerDetail(symbol: String, completion: @escaping (Result<TickerDetailData, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        guard !task.isCancelled else { return nil }
        
        let endpoint = APIEndpoints.getTickerDetail(with: symbol)
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
