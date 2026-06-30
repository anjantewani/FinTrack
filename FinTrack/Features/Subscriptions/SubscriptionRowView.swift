//
//  SubscriptionRowView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 15/05/26.
//

import SwiftUI

struct SubscriptionRowView: View {
    let subscription: Subscription
    
    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(subscription.name)")
                        .font(AppTypography.subtitle)
                                        
                    Text("Renews on \(FormattingHelpers.shared.dateFormatter(for: subscription.nextBillingDate, with: "MMM d"))")
                        .font(AppTypography.secondary)
                        .foregroundStyle(.secondary)
                }
                .padding(AppSpacing.md)
                
                Spacer()
                
                Text("₹ \(subscription.amount, specifier: "%.2f")")
                    .font(AppTypography.subtitle)
            }
        }
        .padding(AppSpacing.md)
    }
}

#Preview {
//    SubscriptionRowView()
}
