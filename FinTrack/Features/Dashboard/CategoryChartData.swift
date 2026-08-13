//
//  CategoryChartData.swift
//  FinTrack
//
//  Created by Anjan Tewani on 13/04/26.
//

import Foundation

struct CategoryChartData: Identifiable, Codable, Hashable {
    let id: UUID
    let category: ExpenseCategory
    let amount: Double
    let percentage: Double
}
