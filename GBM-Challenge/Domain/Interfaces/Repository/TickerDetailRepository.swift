//
//  TickerDetailRepository.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

protocol TickerDetailRepository {
    @discardableResult
    func fetchTickerDetail(symbol: String, completion: @escaping (Result<TickerDetailData, Error>) -> Void) -> Cancellable?
}
