//
//  ExpensesViewModel.swift
//  FinTrack
//
//  Created by Anjan Tewani on 30/12/25.
//

import Foundation

enum ExpensesViewState {
    case empty
    case loaded([Expense])
}

class ExpensesViewModel: ObservableObject {
//    var dummyExpenses: [Expense] = [
//        Expense(id: UUID(), title: "Coffee", amount: 120, date: Date()),
//        Expense(id: UUID(), title: "Lunch", amount: 220, date: Date())
//    ]
    var dummyExpenses: [Expense] = []

    @Published var state: ExpensesViewState = .empty

    func loadExpenses() {
        state = dummyExpenses.isEmpty ? .empty : .loaded(dummyExpenses)
    }
    
    func addExpenseTapped(withTitle: String, withAmount: String) {
        if let amount = Double(withAmount) {
            let expense = Expense(id: UUID(), title: withTitle, amount: amount, date: .now)
            dummyExpenses.append(expense)
            loadExpenses()
        }
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
        withIndexes.forEach({ withIndex in
            dummyExpenses.remove(at: withIndex)
        })
        loadExpenses()
    }
}
