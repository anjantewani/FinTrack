//
//  CategoryTotalRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 06/04/26.
//

import SwiftUI

struct CategoryTotalRowView: View {
    let category: ExpenseCategory
    let totalAmount: Double
    
    var body: some View {

        HStack(alignment: .center, spacing: AppSpacing.sm) {
            Image(systemName: category.icon)
                .frame(width: 20)
                .fontWeight(.thin)
            
            Text(category.title)
                .font(AppTypography.body)
            
            Spacer()
            
            Text("₹ \(totalAmount, specifier: "%.2f")")
                .font(AppTypography.body)
        }
        .padding(AppSpacing.xs)
    }
}

//#Preview {
//    CategoryTotalRowView()
//}
