//
//  BarChartRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 14/04/26.
//

import SwiftUI

struct BarChartRowView: View {
    
    @State private var animate: Bool = false
    
    let icon: String
    let category: String
    let amount: Double
    let percentage: Double
    let minWidth: CGFloat = 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack(spacing: AppSpacing.md) {
                Label(category, systemImage: icon)
                
                Spacer()
                
                Text("₹ \(amount, specifier: "%.2f")")
                    .font(AppTypography.subtitle)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(AppColors.accentSecondaryDisabled.opacity(0.5))
                        .frame(width: geometry.size.width, height: 12)
                        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.sm))
                    Rectangle()
                        .fill(AppColors.accentPrimary)
                        .frame(width: (animate ? max(CGFloat(geometry.size.width * percentage), minWidth) : 0), height: 12)
                        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.sm))
                }
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, AppSpacing.sm)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                self.animate = true
            }
        }
    }
}

#Preview {
    BarChartRowView(icon: "car", category: "Category", amount: 200, percentage: 0.4)
}
