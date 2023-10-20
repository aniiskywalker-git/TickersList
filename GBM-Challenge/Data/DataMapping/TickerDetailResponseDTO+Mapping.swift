//
//  TickerDetailResponseDTO+Mapping.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

struct TickersDetailResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case detail = "data"
    }
    
    let detail: TickerDetailDTO
}

extension TickersDetailResponseDTO {
    struct TickerDetailDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case name
            case symbol
            case eodItem = "eod"
        }
        
        let name: String
        let symbol: String?
        let eodItem: [EodItemDTO]
    }
}

extension TickersDetailResponseDTO {
    struct EodItemDTO: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case open
            case close
            case high
            case low
            case volume
            case date
        }
        
        let open: Double?
        let close: Double?
        let high: Double?
        let low: Double?
        let volume: Double?
        let date: String?
    }
}

// MARK: - Mappings to Domain

extension TickersDetailResponseDTO {
    func toDomain() -> TickerDetailData {
        return .init(tickerDetail: detail.toDomain())
    }
}

extension TickersDetailResponseDTO.TickerDetailDTO {
    func toDomain() -> TickerDetail {
        return .init(name: name, symbol: symbol, eodItem: eodItem.map { $0.toDomain() })
    }
}

extension TickersDetailResponseDTO.EodItemDTO {
    func toDomain() -> EodItem {
        return .init(open: open, close: close, high: high, low: low, volume: volume, date: date)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
