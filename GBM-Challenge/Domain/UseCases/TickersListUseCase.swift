//
//  TickersListUseCase.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

protocol TickersListUseCase {
    func execute(
        completion: @escaping (Result<Tickers, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultTickersListUseCase: TickersListUseCase {

    private let tickersRepository: TickersRepository
    
    init(tickersRepository: TickersRepository) {
        self.tickersRepository = tickersRepository
    }

    func execute(
        completion: @escaping (Result<Tickers, Error>) -> Void
    ) -> Cancellable? {

        return tickersRepository.fetchTickers { result in
            completion(result)
        }
    }
}

