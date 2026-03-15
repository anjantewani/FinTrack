//
//  ExpensesStore.swift
//  FinTrack
//
//  Created by Anjan Tewani on 12/03/26.
//

import Foundation

protocol ExpensesStore {
    func loadExpenses() -> [Expense]
    func saveExpenses(_ expenses: [Expense])
}
