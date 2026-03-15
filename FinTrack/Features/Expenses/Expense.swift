//
//  Expense.swift
//  FinTrack
//
//  Created by Anjan Tewani on 30/12/25.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id: UUID
    var title: String
    var amount: Double
    var date: Date
}
