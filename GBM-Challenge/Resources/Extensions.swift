//
//  Extensions.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 20/10/23.
//

import Foundation

enum Formatters {
    case iso8601
    case iso
    case deliveryDate
    case day
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
            
        switch self {
        case .iso8601:
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        case .iso:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        case .deliveryDate:
            formatter.dateFormat = "MMM dd, yyyy"
        case .day:
            formatter.dateFormat = "dd"
        }
        return formatter
    }
}

extension String {
    func asFormat(from: Formatters, to: Formatters) -> String? {
        guard let date = from.dateFormatter().date(from: self) else {
            return nil
        }
        let oneDay: TimeInterval = 86400
        let datePlusDay = date.addingTimeInterval(oneDay)
        return to.dateFormatter().string(from: datePlusDay)
    }
}
