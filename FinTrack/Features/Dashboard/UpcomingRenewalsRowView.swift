//
//  UpcomingRenewalsRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 12/08/26.
//

import SwiftUI

struct UpcomingRenewalsRowView: View {
    private let colorPallete: [Color] = [.indigo, .blue, .yellow, .green, .orange, .cyan, .brown, .red, .pink]
    let upcomingRenewal: Subscription
    
    var body: some View {
        let selectedColor = colorPallete.randomElement() ?? AppColors.accentPrimary
        HStack(alignment: .center) {
            Image(systemName: "calendar")
                .frame(width: 30, height: 30)
                .imageScale(.large)
                .foregroundStyle(selectedColor)

            VStack(alignment: .leading) {
                Text(upcomingRenewal.name)
                    .font(AppTypography.secondary)
                    .fontWeight(.semibold)
                
                Text("₹ \(upcomingRenewal.amount, specifier: "%.0f") • \(upcomingRenewal.billingCycle.title)")
                    .font(AppTypography.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            let calendar = Calendar.current
            if let day = calendar.dateComponents([.day], from: .now, to: upcomingRenewal.nextBillingDate).day {
                Text("\(day) \(day > 1 ? "days" : "day") left")
                    .font(AppTypography.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(AppColors.accentPrimary)
                    .padding(AppSpacing.sm)
                    .background(AppColors.accentSecondaryDisabled.opacity(0.20))
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.sm))
            }
        }
    }
}

#Preview {
    UpcomingRenewalsRowView(upcomingRenewal: Subscription(id: UUID(), name: "Claude", amount: 250, nextBillingDate: .now, billingCycle: .monthly))
}
