//
//  TickersListItemViewModel.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 19/10/23.
//

import Foundation

struct TickersListItemViewModel: Equatable {
    let name: String?
    let symbol: String?
    let latest: String?
    let stockName: String?
    let acronym: String?
    let country: String?
}

extension TickersListItemViewModel {
    
    init(ticker: Ticker) {
        self.name = ticker.name
        self.symbol = ticker.symbol
        self.latest = ""
        self.stockName = ticker.stock?.name
        self.acronym = ticker.stock?.acronym
        self.country = ticker.stock?.country
    }
}
