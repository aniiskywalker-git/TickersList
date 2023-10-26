//
//  TickerDetailRepository.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

protocol TickerDetailsRepository {
    @discardableResult
    func fetchTickerDetail(symbol: String, completion: @escaping (Result<TickerDetailsData, Error>) -> Void) -> Cancellable?
}
