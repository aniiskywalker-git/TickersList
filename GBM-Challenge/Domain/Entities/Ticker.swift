//
//  Ticker.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

struct Ticker: Equatable {
    let name: String?
    let symbol: String?
    let stock: Stock?
}

struct Stock: Equatable {
    let name: String?
    let acronym: String?
    let country: String?
}

struct Tickers: Equatable {
    var tickers: [Ticker]
}


