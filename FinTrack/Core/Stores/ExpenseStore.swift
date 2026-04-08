//
//  ExpenseStore.swift
//  FinTrack
//
//  Created by Anjan Tewani on 21/03/26.
//

import Foundation

class ExpenseStore: ObservableObject {
    @Published var expenses: [Expense] = []
    private let persistence: ExpensesStore
    
    init(persistence: ExpensesStore) {
        self.persistence = persistence
    }
    
    func loadExpenses() {
        expenses = persistence.loadExpenses()
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        persistence.saveExpenses(expenses)
    }
    
    func deleteExpense(_ indexSet: IndexSet) {
        expenses.remove(atOffsets: indexSet)
        persistence.saveExpenses(expenses)
    }
}
