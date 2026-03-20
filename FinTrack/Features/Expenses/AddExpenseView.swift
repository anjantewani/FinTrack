//
//  AddExpenseView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 05/02/26.
//

import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    @State private var expenseTitle: String = ""
    @State private var expenseAmount: String = ""
    @State private var selectedCategory: ExpenseCategory = .food
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            
            Text("Category")
            Picker("Category", selection: $selectedCategory) {
                ForEach(ExpenseCategory.allCases, id: \.self) { category in
                    Label(category.title, systemImage: category.icon)
                        .tag(category)
                }
            }
            .pickerStyle(.menu)
            .padding(.bottom, AppSpacing.lg)
            
            Text("Title")
            TextField(text: $expenseTitle) {
                Text("Title")
            }
            .textFieldStyle(.plain)
            .padding(.bottom, AppSpacing.md)

            Text("Amount")
            TextField(text: $expenseAmount) {
                Text("Amount")
            }
            .textFieldStyle(.plain)
            .padding(.bottom, AppSpacing.lg)

            PrimaryButton(title: "Add Expense", action: {
                expensesViewModel.addExpenseTapped(withTitle: expenseTitle, withAmount: expenseAmount, withCategory: selectedCategory)
                dismiss()
            }, isEnable: expensesViewModel.checkAddButtonEnability(withTitle: expenseTitle, withAmount: expenseAmount))
            
            Spacer()
        }
        .padding(.vertical, AppSpacing.sm)
        .padding(.horizontal, AppSpacing.md)
        
    }
}

#Preview {
//    AddExpenseView(expensesViewModel: ExpensesViewModel(), expenseTitle: "", expenseAmount: "")
}
