//
//  ExpenseCategory.swift
//  FinTrack
//
//  Created by Anjan Tewani on 19/03/26.
//

import Foundation

enum ExpenseCategory: String, CaseIterable, Codable {
    case food
    case transport
    case bills
    case rent
    case shopping
    case other
    
    var title: String {
        switch self {
        case .food:
            return "Food"
        case .transport:
            return "Transport"
        case .bills:
            return "Bills"
        case .rent:
            return "Rent"
        case .shopping:
            return "Shopping"
        case .other:
            return "Other"
        }
    }
    
    var icon: String {
        switch self {
        case .food:
            return "fork.knife.circle"
        case .transport:
            return "car"
        case .bills:
            return "printer"
        case .rent:
            return "checkmark.seal.text.page"
        case .shopping:
            return "cart"
        case .other:
            return "shippingbox"
        }
    }
}
