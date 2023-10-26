//
//  TickerDetails+Stub.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 25/10/23.
//

import Foundation
@testable import GBM_Challenge

extension TickerDetail {
    static func stub(name: String = "Microsoft Corporation",
                     symbol: String = "MSFT" ,
                     eodItem: [EodItem] = [EodItem.stub()]) -> Self {
        TickerDetail(name: name, symbol: symbol, eodItem: eodItem)
    }
}

extension EodItem {
    static func stub(open: Double = 133.4,
                     close: Double = 140.24,
                     high: Double = 290.28,
                     low: Double = 192.29,
                     volume: Double = 9393920.0,
                     date: String = "2023-06-05T00:00:00+0000") -> Self {
        EodItem(open: open, close: close, high: high, low: low, volume: volume, date: date)
        
    }
}
