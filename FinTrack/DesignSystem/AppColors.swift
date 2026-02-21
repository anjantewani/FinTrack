//
//  AppColors.swift
//  FinTrack
//
//  Created by Anjan Tewani on 28/12/25.
//

import Foundation
import SwiftUI

enum AppColors {
    static let accentPrimary = Color.indigo
    static let accentPrimaryDisabled = accentPrimary.opacity(0.5)

    static let accentSecondary = accentPrimary.opacity(0.75)
    static let accentSecondaryDisabled = accentSecondary.opacity(0.5)
    
    
    static let textOnAccentPrimary = Color.white
    static let textOnAccentPrimaryDisabled = textOnAccentPrimary.opacity(0.5)

    static let textOnAccentSecondary = textOnAccentPrimary.opacity(0.9)
    static let textOnAccentSecondaryDisabled = textOnAccentSecondary.opacity(0.5)
    
    static let cardBackground = Color.gray.opacity(0.2)
}
