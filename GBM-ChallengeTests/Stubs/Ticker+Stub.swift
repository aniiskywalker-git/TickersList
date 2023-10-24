//
//  Ticker+Stub.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import Foundation
@testable import GBM_Challenge

extension Ticker {
    static func stub(name: String = "Microsoft Corporation",
                     symbol: String = "MSFT" ,
                     stock: Stock = Stock.stub()) -> Self {
        Ticker(name: name,
               symbol: symbol,
               stock: stock)
    }
}

extension Stock {
    static func stub(name: String = "NASDAQ Stock Exchange",
                     acronym: String = "NASDAQ",
                     country: String = "USA") -> Self {
        Stock(name: name, acronym: acronym, country: country)
        
    }
}
