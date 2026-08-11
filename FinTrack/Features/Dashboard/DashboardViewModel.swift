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
    private let expenseStore: ExpenseStore
    private let subscriptionStore: SubscriptionStore
    
    var expenses: [Expense] {
        expenseStore.expenses
    }
    
    var subscriptions: [Subscription] {
        subscriptionStore.subscriptions
    }
    
    var monthlySubsTotalAmount: Double {
        let monthlySubs = subscriptions.filter({ $0.billingCycle == .monthly } )
        return monthlySubs.reduce(0, { $0 + $1.amount })
    }
    
    var activeMonthlySubs: Int {
        let monthlySubs = subscriptions.filter({ $0.billingCycle == .monthly })
        let activeSubs = monthlySubs.filter({ $0.nextBillingDate > Date.now })
        return activeSubs.count
    }
    
    var yearlySubsTotalAmount: Double {
        let monthlySubs = subscriptions.filter({ $0.billingCycle == .yearly } )
        return monthlySubs.reduce(0, { $0 + $1.amount })
    }
    
    var activeYearlySubs: Int {
        let monthlySubs = subscriptions.filter({ $0.billingCycle == .yearly })
        let activeSubs = monthlySubs.filter({ $0.nextBillingDate > Date.now })
        return activeSubs.count
    }
    
    var totalAmount: Double {
        return expenseStore.expenses.reduce(0) { $0 + $1.amount }
    }
    
    var expensePercentAgaintPreviousMonth: Double {
        return Utilities.shared.expensePercentAgainstPreviousMonth(expenses: expenses)
    }
    
    var insightPercentText: String {
        let percent: String = String(format: "%.0f", abs(expensePercentAgaintPreviousMonth))
        return "\(percent)% \(expensePercentAgaintPreviousMonth >= 0 ? "more" : "less")"
    }
    
    var insightGuidanceText: String {
        return expensePercentAgaintPreviousMonth >= 0 ? "Keep an eye on your spending!" : "You're managing your spending well!"
    }
    
    var insightPercentColor: Color {
        return expensePercentAgaintPreviousMonth >= 0 ? Color.red : Color.green
    }
    
    var previousMonthTotalExpense: Double {
        return Utilities.shared.previousMonthTotalExpense(expenses: expenses)
    }
    
    var currentMonthTotalExpense: Double {
        return Utilities.shared.currentMonthTotalExpense(expenses: expenses)
    }
    
    var maxAmount: Double = 0

    @Published var recentExpenses: [Expense] = []
    @Published var categoryTotals: [ExpenseCategory: Double] = [:]
    @Published var categoryChartData: [CategoryChartData] = []
    
    init(expenseStore: ExpenseStore, subscriptionStore: SubscriptionStore) {
        self.expenseStore = expenseStore
        self.subscriptionStore = subscriptionStore
        
        expenseStore.$expenses
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
                
//                MARK: For percentage calculation, not using `(amount * 100)/totalAmount` because in UI we need (0.1, 0.5, etc) as values for bar width and not (10, 50, etc)
                self.categoryChartData = sortedCategoryTotalsArray.map { sortedCategoryTotal in
                    return CategoryChartData(id: UUID(), category: sortedCategoryTotal.0, amount: sortedCategoryTotal.1, percentage: (sortedCategoryTotal.1)/self.totalAmount)
                }
            }
            .store(in: &cancellables)
        
        subscriptionStore.$subscriptions
            .sink { [weak self] subscriptions in
            }
            .store(in: &cancellables)
    }
}
