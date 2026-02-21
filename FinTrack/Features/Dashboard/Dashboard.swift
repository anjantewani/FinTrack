//
//  Dashboard.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        VStack {            
            HStack {
                PrimaryButton(title: "Primary", action: {})
                
                PrimaryButton(title: "Primary", action: {}, isEnable: false)
            }

            HStack {
                SecondaryButton(title: "Secondary", action: {})
                
                SecondaryButton(title: "Secondary", action: {}, isEnabled: false)
            }
            .padding(.bottom, AppSpacing.lg)
            
            CardView {
                VStack {
                    Text("Card View")
                }
            }
            .padding(.bottom, AppSpacing.lg)
            
            
            EmptyStateView(image: Image(systemName: "exclamationmark.triangle"), title: "No Data", description: "You haven't added data yet.") {
                PrimaryButton(title: "Add Data", action: {
                    print("Add Data Tapped")
                })
            }
            .padding(.top, AppSpacing.lg)
        }
    }
}

#Preview {
    Dashboard()
}
