//
//  PrimaryButton.swift
//  FinTrack
//
//  Created by Anjan Tewani on 28/12/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isEnable: Bool = true

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.body)
                .padding(AppSpacing.sm)
        }
        .background(isEnable ? AppColors.accentPrimary : AppColors.accentPrimaryDisabled)
        .foregroundStyle(isEnable ? AppColors.textOnAccentPrimary : AppColors.textOnAccentPrimaryDisabled)
        .clipShape(.rect(cornerRadius: AppCornerRadius.sm))
        .disabled(!isEnable)
    }
}

#Preview {
    
    VStack {
        PrimaryButton(title: "Primary", action: {
            print("Primary button tapped")
        }, isEnable: true)
        
        PrimaryButton(title: "Primary Disabled", action: {}, isEnable: false)
    }
}
