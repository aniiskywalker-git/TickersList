//
//  TickerDetailsItemViewModel.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 20/10/23.
//

import Foundation

struct TickerDetailsItemViewModel: Equatable {
    let open: Double?
    let close: Double?
    let high: Double?
    let low: Double?
    let volume: Double?
    let date: String?
    let day: String?
}

extension TickerDetailsItemViewModel {
    
    init(eod: EodItem) {
        self.open = eod.open
        self.close = eod.close
        self.high = eod.high
        self.low = eod.low
        self.volume = eod.volume
        if let date = eod.date {
            self.date = date.asFormat(from: .iso8601, to: .deliveryDate)
            self.day = date.asFormat(from: .iso8601, to: .day)
        } else {
            self.date = ""
            self.day = ""
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy"
    formatter.timeZone = .current
    return formatter
}()

private func addingOneDay(date: Date) -> String? {
    let oneDay: TimeInterval = 86400
    let datePlusDay = date.addingTimeInterval(oneDay)
    return dateFormatter.string(from: datePlusDay)
}
