//
//  TickerDetail.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation


struct TickerDetail: Equatable {
    
    let name: String?
    let symbol: String?
    let eodItem: [EodItem]
}

struct TickerDetailsData: Equatable {
    let tickerDetail: TickerDetail
}

struct EodItem: Equatable {
    let open: Double?
    let close: Double?
    let high: Double?
    let low: Double?
    let volume: Double?
    let date: String?
}


