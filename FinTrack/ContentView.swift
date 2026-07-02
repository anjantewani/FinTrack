//
//  ContentView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var subscriptionStore: SubscriptionStore
    @EnvironmentObject private var expenseStore: ExpenseStore
    
    var body: some View {
        
        TabView {
            NavigationStack {
                Dashboard(dashboardViewModel: DashboardViewModel(store: expenseStore))
                    .navigationTitle("Dashboard")
            }
            .tabItem() {
                Label("Dashboard", systemImage: "chart.pie.fill")
            }
            
            NavigationStack {
                Expenses(expensesViewModel: ExpensesViewModel(store: expenseStore))
                    .navigationTitle("Expenses")
            }
            .tabItem() {
                Label("Expenses", systemImage: "banknote")
            }
            
            NavigationStack {
                Subscriptions(subscriptionsViewModel: SubscriptionsViewModel(store: subscriptionStore))
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
     
        .task {
            expenseStore.loadExpenses()
            subscriptionStore.loadSubscriptions()
        }
    }
}

#Preview {
    ContentView()
}
