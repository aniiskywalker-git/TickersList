//
//  APIEndpoints.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

struct APIEndpoints {
    
    static func getTickers() -> Endpoint<TickersResponseDTO> {

        return Endpoint(
            path: "tickers",
            method: .get
        )
    }

    static func getTickerDetail(with symbol: String) -> Endpoint<TickersDetailResponseDTO> {
        
        return Endpoint(
            path: "tickers/\(symbol)/eod",
            method: .get
        )
    }
}
