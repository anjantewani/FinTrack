//
//  FinTrackApp.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

@main
struct FinTrackApp: App {
    
    @StateObject private var subscriptionStore: SubscriptionStore
    @StateObject private var expenseStore: ExpenseStore
    
//    MARK: Initializing the file as the @StateObject has dependencies in initialization and cannot directly reference those properties to initalize the @StateObject (that is subscriptionStore & expenseStore)

    init() {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
//        MARK: Usually swiftUI automatically creates the wrapper for @StateObject automatically behind the scenes, but when there are dependencies like this we need to manually create the wrapper and put the state object with depencdencies injected inside it and then assign it to _expenseStore, which generally gets automatically created if no dependencies.

        let subscriptionsFileURL = documentURL.appending(component: "subscriptions.json")
        let subscriptionsPersistence = LocalSubscriptionsStore(fileURL: subscriptionsFileURL)
        _subscriptionStore = StateObject(
            wrappedValue: SubscriptionStore(persistence: subscriptionsPersistence)
        )

        let expensesFileURL = documentURL.appending(component: "expenses.json")
        let expensesPersistence = LocalExpensesStore(fileURL: expensesFileURL)
        _expenseStore = StateObject(
            wrappedValue: ExpenseStore(persistence: expensesPersistence)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(subscriptionStore)
                .environmentObject(expenseStore)
        }
    }
}
