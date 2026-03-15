//
//  Expenses.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Expenses: View {
    @StateObject private var expensesViewModel: ExpensesViewModel
    @State var showAddExpense: Bool = false
    
//    MARK: Initializing the View as the @StateObject has dependencies in initialization and cannot directly reference those properties to initalize the @StateObject (that is view model)
    init() {
        let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileUrl = directoryUrl.appending(component: "expenses.json")
        
        let store = LocalExpensesStore(fileURL: fileUrl)
        
//        MARK: Usually swiftUI automatically creates the wrapper for @StateObject automatically behind the scenes, but when there are dependencies like this we need to manually create the wrapper and put the state object with depencdencies injected inside it and then assign it to _expenseViewModel, which generally gets automatically created if no dependencies.
        _expensesViewModel = StateObject(
            wrappedValue: ExpensesViewModel(store: store)
        )
    }
    
    var body: some View {
        content
            .onAppear() {
                expensesViewModel.loadExpenses()
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddExpense = true
                    } label: {
                        Text("Add Expense")
                    }
                }
            }
            .sheet(isPresented: $showAddExpense) {
                NavigationStack {
                    AddExpenseView(expensesViewModel: expensesViewModel, expenseTitle: "", expenseAmount: "")
                        .navigationTitle("Add Expense")
                }
            }
    }
    
    @ViewBuilder
    var content: some View {
        switch expensesViewModel.state {
        case .empty:
            EmptyStateView(title: "No Expenses", description: "You have no expenses yet.", action: {})
            
        case .loaded(let expenses):
            List {
                ForEach(expenses) { expense in
                    NavigationLink {
                        ExpenseDetailView(expense: expense)
                    } label: {
                        ExpenseRowView(expense: expense)
                    }
                }
                .onDelete(perform: { indexes in
                    expensesViewModel.deleteExpenses(withIndexes: indexes)
                })
            }
        }
    }
}

#Preview {
    Expenses()
}
