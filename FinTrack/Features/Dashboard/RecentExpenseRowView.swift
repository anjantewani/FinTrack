//
//  RecentExpenseRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 06/04/26.
//

import SwiftUI

struct RecentExpenseRowView: View {
    private let colorPallete: [Color] = [.indigo, .blue, .yellow, .green, .orange, .cyan, .brown, .red, .pink]
    let expense: Expense
    
    var body: some View {
        let selectedColor = colorPallete.randomElement() ?? Color.accentColor
        HStack(alignment: .center, spacing: AppSpacing.sm) {
            Image(systemName: expense.category.icon)
                .frame(width: 30, height: 30)
                .imageScale(.large)
                .foregroundStyle(selectedColor)

            VStack(alignment: .leading) {
                Text(expense.title)
                    .font(AppTypography.secondary)
                    .fontWeight(.semibold)

                Text(expense.category.title)
                    .font(AppTypography.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
                        
            Text("\(FormattingHelpers.shared.dateFormatter(for: expense.date, with: "MMM dd"))")
                .font(AppTypography.secondary)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            
            Text("₹ \(expense.amount, specifier: "%.0f")")
                .font(AppTypography.secondary)
                .fontWeight(.semibold)
                .frame(width: 80, alignment: .trailing)
                .padding(.leading, AppSpacing.sm)
        }
    }
}

#Preview {
    RecentExpenseRowView(expense: Expense(id: UUID(), title: "Gaming Keyboard", amount: 200000.00, date: Date(), category: .bills))
}
