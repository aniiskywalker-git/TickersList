//
//  TickerDetailResponseDTO+Mapping.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

struct TickersResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case tickers = "data"
    }
    
    let tickers: [TickerDTO]
}

extension TickersResponseDTO {
    struct TickerDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case name
            case symbol
            case stock = "stock_exchange"
        }
        
        let name: String?
        let symbol: String?
        let stock: StockDTO?
    }
}
extension TickersResponseDTO {
    struct StockDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case name
            case acronym
            case country
        }
        
        let name: String?
        let acronym: String?
        let country: String?
    }
    
}
// MARK: - Mappings to Domain

extension TickersResponseDTO {
    func toDomain() -> Tickers {
        return .init(tickers: tickers.map{ $0.toDomain() })
    }
}

extension TickersResponseDTO.TickerDTO {
    func toDomain() -> Ticker {
        return .init(name: name, symbol: symbol, stock: stock?.toDomain())
    }
}

extension TickersResponseDTO.StockDTO {
    func toDomain() -> Stock {
        return .init(name: name, acronym: acronym, country: country)
    }
}
