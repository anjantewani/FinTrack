//
//  SecondaryButton.swift
//  FinTrack
//
//  Created by Anjan Tewani on 29/12/25.
//

import SwiftUI

struct SecondaryButton: View {
    
    var title: String
    var action: () -> Void
    var isEnabled: Bool = true
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(AppTypography.body)
                .padding(AppSpacing.sm)
        }
        .background(isEnabled ? AppColors.accentSecondary : AppColors.accentSecondaryDisabled)
        .foregroundStyle(isEnabled ? AppColors.textOnAccentSecondary : AppColors.textOnAccentSecondaryDisabled)
        .clipShape(.rect(cornerRadius: AppCornerRadius.sm))
        .disabled(!isEnabled)
    }
}

#Preview {
    
    VStack {
        SecondaryButton(title: "Secondary", action: {
            print("Secondary button tapped")
        })
        SecondaryButton(title: "Secondary Disabled", action: {}, isEnabled: false)
        
    }
}
