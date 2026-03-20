//
//  ExpensesViewModel.swift
//  FinTrack
//
//  Created by Anjan Tewani on 30/12/25.
//

import Foundation

enum ExpensesViewState {
    case loading
    case empty
    case loaded([Expense])
    case error
}

@MainActor class ExpensesViewModel: ObservableObject {
    var store: LocalExpensesStore
    @Published var state: ExpensesViewState = .empty
    
    init(store: LocalExpensesStore) {
        self.store = store
    }
    
    func loadExpenses() {
        state = .loading
        Task {
            try await Task.sleep(for: .seconds(3))
            let expenses = self.store.loadExpenses()
            self.state = expenses.isEmpty ? .empty : .loaded(expenses)
        }
    }
    
    func addExpenseTapped(withTitle: String, withAmount: String, withCategory: ExpenseCategory) {
        guard let amount = Double(withAmount) else { return }
        var currentExpenses: [Expense] = []
        if case(.loaded(let expenses)) = state {
            currentExpenses = expenses
        }
        let expense = Expense(id: UUID(), title: withTitle, amount: amount, date: .now, category: withCategory)
        currentExpenses.append(expense)
        store.saveExpenses(currentExpenses)
        state = .loaded(currentExpenses)
    }
    
    func checkAddButtonEnability(withTitle: String, withAmount: String) -> Bool {
        var enableAddButton = false
        if let _ = Double(withAmount) {
            if !withTitle.isEmpty {
                enableAddButton = true
            }
        }
        return enableAddButton
    }
    
    func deleteExpenses(withIndexes: IndexSet) {
        var currentExpenses: [Expense] = []
        guard case(.loaded(let expenses)) = state else { return }
        currentExpenses = expenses
        currentExpenses.remove(atOffsets: withIndexes)
        store.saveExpenses(currentExpenses)
        state = currentExpenses.isEmpty ? .empty : .loaded(currentExpenses)
    }
}
