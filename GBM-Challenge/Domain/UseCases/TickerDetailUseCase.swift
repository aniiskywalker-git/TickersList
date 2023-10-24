//
//  TickerDetailUseCase.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation


protocol TickerDetailUseCase {
    func execute(symbol: String,
        completion: @escaping (Result<TickerDetailData, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultTickerDetailUseCase: TickerDetailUseCase {
    
    private let tickerDetailRepository: TickerDetailRepository
    
    init(tickerDetailRepository: TickerDetailRepository) {
        self.tickerDetailRepository = tickerDetailRepository
    }
    
    func execute(symbol: String,
                 completion: @escaping (Result<TickerDetailData, Error>) -> Void) -> Cancellable? {
        return tickerDetailRepository.fetchTickerDetail(symbol: symbol) { result in
            completion(result)
        }
    }

}
