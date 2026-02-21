//
//  CardView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 29/12/25.
//

import SwiftUI

struct CardView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(AppSpacing.md)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
    }
}

#Preview {
    
    CardView {
        VStack {
            Text("Card View")
        }
    }
    
}
