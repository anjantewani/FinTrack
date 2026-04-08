//
//  DashboardViewModel.swift
//  FinTrack
//
//  Created by Anjan Tewani on 05/04/26.
//

import Foundation
import Combine

@MainActor class DashboardViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let store: ExpenseStore
    var expenses: [Expense] {
        store.expenses
    }
    var totalAmount: Double {
        return store.expenses.reduce(0) { $0 + $1.amount }
    }

    @Published var recentExpenses: [Expense] = []
    @Published var categoryTotals: [ExpenseCategory: Double] = [:]
    
    init(store: ExpenseStore) {
        self.store = store
        
        store.$expenses
            .sink { [weak self] expenses in
                guard let self else { return }
                self.recentExpenses = Array(expenses.suffix(3).reversed())
                let categorizedExpenses = Dictionary(grouping: expenses) { $0.category }
                self.categoryTotals = categorizedExpenses.reduce(into: [ExpenseCategory: Double]()) { categoryTotals, categorizedExpenses in
                    categoryTotals[categorizedExpenses.key] = categorizedExpenses.value.reduce(0) { $0 + $1.amount}
                }
            }
            .store(in: &cancellables)
    }
}
