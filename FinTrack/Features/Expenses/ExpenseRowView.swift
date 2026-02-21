//
//  ExpenseRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 04/02/26.
//

import SwiftUI

struct ExpenseRowView: View {
    let expense: Expense
    
    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            HStack {
                Text("\(expense.date.formatted(date: .abbreviated, time: .omitted))")
                    .font(AppTypography.body)
                
                Spacer()
            }
            HStack {
                Text("\(expense.title)")
                    .font(AppTypography.title)
                
                Spacer()
                
                Text("₹ \(expense.amount, specifier: "%.2f")")
                    .font(AppTypography.title)
            }
        }
        .padding(AppSpacing.md)
    }
}

#Preview {
    let expense = Expense(id: UUID(), title: "Coffee", amount: 100.00, date: Date.now)
    ExpenseRowView(expense: expense)
}
