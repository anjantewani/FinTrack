//
//  EmptyStateView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 30/12/25.
//

import SwiftUI

struct EmptyStateView<Action: View>: View {
    var image: Image?
    var title: String?
    var description: String?
    var action: Action?
    
    init(image: Image? = nil, title: String? = nil, description: String? = nil, @ViewBuilder action: () -> Action? = { nil }) {
        
        self.image = image
        self.title = title
        self.description = description
        self.action = action()
    }
    
    var body: some View {
        
        VStack(spacing: AppSpacing.xs) {
            if let image = image {
                image
                    .imageScale(.large)
                    .padding(.bottom, AppSpacing.sm)
            }
            
            if let title = title {
                Text(title)
                    .font(AppTypography.title)
            }
            
            if let description = description {
                Text(description)
                    .font(AppTypography.body)
                    .multilineTextAlignment(.center)
            }
            
            if let action = action {
                action
                    .padding(AppSpacing.lg)
            }
        }
        .padding(AppSpacing.lg)
    }
}

#Preview {
    EmptyStateView(image: Image(systemName: "exclamationmark.triangle"), title: "No cards are added!", description: "Enter card details to register a new card") {
        
        PrimaryButton(title: "Add Card", action: {
            print("Add card details")
        })
    }
}
