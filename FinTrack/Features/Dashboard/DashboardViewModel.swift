//
//  DashboardViewModel.swift
//  FinTrack
//
//  Created by Anjan Tewani on 05/04/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor class DashboardViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let store: ExpenseStore
    var expenses: [Expense] {
        store.expenses
    }
    var totalAmount: Double {
        return store.expenses.reduce(0) { $0 + $1.amount }
    }
    
    var maxAmount: Double = 0

    @Published var recentExpenses: [Expense] = []
    @Published var categoryTotals: [ExpenseCategory: Double] = [:]
    @Published var categoryChartData: [CategoryChartData] = []
    
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
                
                let categoryTotalsArray: [(ExpenseCategory, Double)] = Array(self.categoryTotals)
                let sortedCategoryTotalsArray = categoryTotalsArray.sorted(by: {$0.1 > $1.1})
                
                self.maxAmount = sortedCategoryTotalsArray.first?.1 ?? 0
                guard self.maxAmount > 0 else {
                    return self.categoryChartData = []
                }
                
//                MARK: For percentage calculation, not using `(amount * 100)/maxAmount` because in UI we need (0.1, 0.5, etc) as values for bar width and not (10, 50, etc)
                self.categoryChartData = sortedCategoryTotalsArray.map { sortedCategoryTotal in
                    return CategoryChartData(category: sortedCategoryTotal.0, amount: sortedCategoryTotal.1, percentage: (sortedCategoryTotal.1)/self.maxAmount)
                }
            }
            .store(in: &cancellables)
    }
}
