//
//  TickerDetailUseCase.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation


protocol TickerDetailsUseCase {
    func execute(symbol: String,
        completion: @escaping (Result<TickerDetailsData, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultTickerDetailsUseCase: TickerDetailsUseCase {
    
    private let tickerDetailRepository: TickerDetailsRepository
    
    init(tickerDetailRepository: TickerDetailsRepository) {
        self.tickerDetailRepository = tickerDetailRepository
    }
    
    func execute(symbol: String,
                 completion: @escaping (Result<TickerDetailsData, Error>) -> Void) -> Cancellable? {
        return tickerDetailRepository.fetchTickerDetail(symbol: symbol) { result in
            completion(result)
        }
    }

}
