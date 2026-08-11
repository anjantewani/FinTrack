//
//  SpendingByCategoryRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 25/07/26.
//

import SwiftUI

struct SpendingByCategoryRowView: View {
    
    @State private var animate: Bool = false
    private let colorPallete: [Color] = [.indigo, .blue, .yellow, .green, .orange, .cyan, .brown, .red, .pink]
    
    let icon: String
    let category: String
    let amount: Double
    let percentage: Double
    let minWidth: CGFloat = 10

    
    var body: some View {
        let selectedColor: Color = colorPallete.randomElement() ?? AppColors.accentPrimary
        HStack(alignment: .center, spacing: AppSpacing.sm) {
            Image(systemName: icon)
                .frame(width: 30, height: 30)
                .foregroundStyle(selectedColor)
                .imageScale(.large)
                .clipShape(Circle())
            
            Text(category)
                .frame(width: 70, alignment: .leading)
                .font(AppTypography.secondary)
                .fontWeight(.medium)
            
            Spacer()
                            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 8, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.sm))
                    Rectangle()
                        .fill(selectedColor)
                        .frame(width: (animate ? max(CGFloat(geometry.size.width * percentage), minWidth) : 0), height: 8)
                        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.sm))
                }
                .frame(maxHeight: .infinity)
            }
            
            Text("₹ \(amount, specifier: "%.0f")")
                .frame(width: 70, alignment: .leading)
                .font(AppTypography.secondary)
                .fontWeight(.semibold)
            
            Text("\(percentage * 100, specifier: "%.0f")%")
                .frame(width: 45, alignment: .leading)
                .font(AppTypography.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                self.animate = true
            }
        }
    }
}

#Preview {
//    SpendingByCategoryRowView()
}
