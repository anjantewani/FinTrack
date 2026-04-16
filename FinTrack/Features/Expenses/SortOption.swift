//
//  SortOption.swift
//  FinTrack
//
//  Created by Anjan Tewani on 13/04/26.
//

import Foundation

enum SortOption: String, CaseIterable, Codable {
    case amountHighToLow
    case amountLowToHigh
    case dateLatest
    case dateOldest
    
    var title: String {
        switch self {
        case .amountHighToLow:
            "Amount: High to Low"
        case .amountLowToHigh:
            "Amount: Low to High"
        case .dateLatest:
            "Date Added: Latest"
        case .dateOldest:
            "Date Added: Oldest"
        }
    }

    var titleShorthand: String {
        switch self {
        case .amountHighToLow:
            "Amount ↑"
        case .amountLowToHigh:
            "Amount ↓"
        case .dateLatest:
            "Date ↑"
        case .dateOldest:
            "Date ↓"
        }
    }
}
