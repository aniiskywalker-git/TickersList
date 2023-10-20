//
//  TickersRepository.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation


protocol TickersRepository {
    @discardableResult
    func fetchTickers(completion: @escaping (Result<Tickers, Error>) -> Void) -> Cancellable?
}
