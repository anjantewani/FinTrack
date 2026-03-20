//
//  ExpenseDetailView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 04/02/26.
//

import SwiftUI

struct ExpenseDetailView: View {
    let expense: Expense
    
    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            Text("\(expense.title)")
                .font(AppTypography.title)
            
            Text("₹ \(expense.amount, specifier: "%.2f")")
                .font(AppTypography.title)
            
            Text("\(expense.date.formatted(date: .abbreviated, time: .omitted))")
                .font(AppTypography.body)
        }
        .padding(AppSpacing.lg)
        .navigationTitle("Expense Detail")
    }
}

#Preview {
    let expense = Expense(id: UUID(), title: "Coffee", amount: 100.00, date: Date.now, category: .food)
    ExpenseDetailView(expense: expense)
}
