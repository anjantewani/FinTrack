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
    var expenses: [Expense] = []
    var store: LocalExpensesStore
    @Published var state: ExpensesViewState = .empty
    
    init(store: LocalExpensesStore) {
        self.store = store
    }

    func loadExpenses() {
//        state = dummyExpenses.isEmpty ? .empty : .loaded(dummyExpenses)
        
        expenses = store.loadExpenses()
        
        state = expenses.count == 0 ? .empty : .loaded(expenses)
        
        
    }
    
    func addExpenseTapped(withTitle: String, withAmount: String) {
        if let amount = Double(withAmount) {
            let expense = Expense(id: UUID(), title: withTitle, amount: amount, date: .now)
            expenses.append(expense)
            
            store.saveExpenses(expenses)
            
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
            expenses.remove(at: withIndex)
            store.saveExpenses(expenses)
        })
        loadExpenses()
    }
}
