//
//  Expenses.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Expenses: View {
    @StateObject private var expensesViewModel = ExpensesViewModel()
    @State var showAddExpense: Bool = false
    
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
