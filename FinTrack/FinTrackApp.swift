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
    
    init() {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentURL.appending(component: "subscriptions.json")
        
        let persistence = LocalSubscriptionsStore(fileURL: fileURL)
        
        _subscriptionStore = StateObject(
            wrappedValue: SubscriptionStore(persistence: persistence)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(subscriptionStore)
        }
    }
}
