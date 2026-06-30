//
//  BillingCycle.swift
//  FinTrack
//
//  Created by Anjan Tewani on 22/04/26.
//

import Foundation

enum BillingCycle: String, CaseIterable, Codable {
    case monthly
    case yearly
    
    var title: String {
        switch self {
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        }
    }
}

extension BillingCycle {
    func nextDate(from date: Date) -> Date? {
        switch self {
        case .monthly:
            return Calendar.current.date(byAdding: DateComponents(month: 1), to: date)
        case .yearly:
            return Calendar.current.date(byAdding: DateComponents(year: 1), to: date)
        }
    }
}
