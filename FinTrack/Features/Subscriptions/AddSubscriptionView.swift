//
//  AddSubscriptionView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 20/05/26.
//

import SwiftUI

struct AddSubscriptionView: View {
    @ObservedObject var subscriptionsViewModel: SubscriptionsViewModel
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var billingCycle: BillingCycle = .monthly
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Name")
            TextField(text: $name) {
                Text("Subscription Name")
            }
            .textFieldStyle(.plain)
            .padding(.bottom, AppSpacing.md)
            
            Text("Amount")
            TextField(text: $amount) {
                Text("Amount")
            }
            .textFieldStyle(.plain)
            .padding(.bottom, AppSpacing.md)
            
            Text("Biiling Cycle")
            Picker("Billing Cycle", selection: $billingCycle) {
                ForEach(BillingCycle.allCases, id: \.self) { billingCycle in
                    Text(billingCycle.title)
                        .tag(billingCycle)
                }
            }
            .pickerStyle(.menu)
            .padding(.bottom, AppSpacing.md)
            
            PrimaryButton(title: "Add Subscription", action: {
                subscriptionsViewModel.addSubscriptionTapped(withName: name, withAmount: amount, withBillingCycle: billingCycle)
                dismiss()
            }, isEnable: subscriptionsViewModel.checkAddButtonEnability(withName: name, withAmount: amount))
            
            Spacer()
        }
        .padding(.vertical, AppSpacing.sm)
        .padding(.horizontal, AppSpacing.md)
    }
}

#Preview {
//    AddSubscriptionView()
}
