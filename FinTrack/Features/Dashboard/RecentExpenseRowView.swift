//
//  RecentExpenseRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 06/04/26.
//

import SwiftUI

struct RecentExpenseRowView: View {
    let expense: Expense
    
    var body: some View {
        HStack(alignment: .center, spacing: AppSpacing.sm) {
            Image(systemName: expense.category.icon)
                .frame(width: 20)
                .fontWeight(.thin)

            Text(expense.title)
                .font(AppTypography.body)
            
            Spacer()
            
            Text("₹ \(expense.amount, specifier: "%.2f")")
                .font(AppTypography.body)
        }
        .padding(AppSpacing.sm)
        
    }
}

#Preview {
    RecentExpenseRowView(expense: Expense(id: UUID(), title: "title", amount: 20.00, date: Date(), category: .bills))
}
