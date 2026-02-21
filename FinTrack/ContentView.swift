//
//  ContentView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            NavigationStack {
                Dashboard()
                    .navigationTitle("Dashboard")
            }
            .tabItem() {
                Label("Dashboard", systemImage: "chart.pie.fill")
            }
            
            NavigationStack {
                Expenses()
                    .navigationTitle("Expenses")
            }
            .tabItem() {
                Label("Expenses", systemImage: "banknote")
            }
            
            NavigationStack {
                Subscriptions()
                    .navigationTitle("Subscriptions")
            }
            .tabItem() {
                Label("Subscriptions", systemImage: "creditcard")
            }
            
            NavigationStack {
                Settings()
                    .navigationTitle("Settings")
            }
            .tabItem() {
                Label("Settings", systemImage: "gear")
            }
        }
        .tint(AppColors.accentPrimary)
        
    }
}

#Preview {
    ContentView()
}
