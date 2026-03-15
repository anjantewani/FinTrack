//
//  AddExpenseView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 05/02/26.
//

import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var expensesViewModel: ExpensesViewModel
    @State var expenseTitle: String
    @State var expenseAmount: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            TextField(text: $expenseTitle) {
                Text("Title")
            }
            .textFieldStyle(.roundedBorder)
            
            TextField(text: $expenseAmount) {
                Text("Amount")
            }
            .textFieldStyle(.roundedBorder)
            
            PrimaryButton(title: "Add Expense", action: {
                expensesViewModel.addExpenseTapped(withTitle: expenseTitle, withAmount: expenseAmount)
                dismiss()
            }, isEnable: expensesViewModel.checkAddButtonEnability(withTitle: expenseTitle, withAmount: expenseAmount))
        }
        .padding(AppSpacing.md)
        
    }
}

#Preview {
//    AddExpenseView(expensesViewModel: ExpensesViewModel(), expenseTitle: "", expenseAmount: "")
}
