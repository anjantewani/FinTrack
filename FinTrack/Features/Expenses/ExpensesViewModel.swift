//
//  ExpensesViewModel.swift
//  FinTrack
//
//  Created by Anjan Tewani on 30/12/25.
//

import Foundation
import Combine

enum ExpensesViewState {
    case loading
    case empty
    case loaded
    case error
}

@MainActor class ExpensesViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let store: ExpenseStore
    var expenses: [Expense] {
        store.expenses
    }
    @Published var state: ExpensesViewState = .empty
    @Published var selectedCategory: ExpenseCategory? = nil
    @Published var selectedSortOption: SortOption = .dateLatest
    
    var filteredExpenses: [Expense] {
        guard let category = selectedCategory else {
            return expenses
        }
        return expenses.filter({ $0.category == category })
    }
    
    var sortedExpenses: [Expense] {
        switch selectedSortOption {
        case .amountHighToLow:
            return filteredExpenses.sorted(by: {$0.amount > $1.amount})
        case .amountLowToHigh:
            return filteredExpenses.sorted(by: {$0.amount < $1.amount})
        case .dateLatest:
            return filteredExpenses.sorted(by: {$0.date > $1.date})
        case .dateOldest:
            return filteredExpenses.sorted(by: {$0.date < $1.date})
        }
    }
    
    init(store: ExpenseStore) {
        self.store = store
        
        store.$expenses
            .sink { [weak self] expenses in
                guard let self else { return }
                self.state = expenses.isEmpty ? .empty : .loaded
            }
            .store(in: &cancellables)
    }
    
    func loadExpenses() {
        state = .loading
        store.loadExpenses()
    }
    
    func addExpenseTapped(withTitle: String, withAmount: String, withCategory: ExpenseCategory) {
        guard let amount = Double(withAmount) else { return }
        let expense = Expense(id: UUID(), title: withTitle, amount: amount, date: .now, category: withCategory)
        store.addExpense(expense)
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
        store.deleteExpense(withIndexes)
    }
}
