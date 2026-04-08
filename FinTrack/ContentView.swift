//
//  ContentView.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenseStore: ExpenseStore
    
//    MARK: Initializing the ContentView as the @StateObject has dependencies in initialization and cannot directly reference those properties to initalize the @StateObject (that is expenseStore)

    init() {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentURL.appending(component: "expenses.json")
        
        let persistence = LocalExpensesStore(fileURL: fileURL)


//        MARK: Usually swiftUI automatically creates the wrapper for @StateObject automatically behind the scenes, but when there are dependencies like this we need to manually create the wrapper and put the state object with depencdencies injected inside it and then assign it to _expenseStore, which generally gets automatically created if no dependencies.
        _expenseStore = StateObject(
            wrappedValue: ExpenseStore(persistence: persistence)
        )
    }
    
    
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
     
        .task {
            expenseStore.loadExpenses()
        }
    }
}

#Preview {
    ContentView()
}
