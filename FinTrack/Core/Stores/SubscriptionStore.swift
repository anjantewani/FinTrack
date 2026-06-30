//
//  SubscriptionStore.swift
//  FinTrack
//
//  Created by Anjan Tewani on 05/05/26.
//

import Foundation

class SubscriptionStore: ObservableObject {
    
    @Published var subscriptions: [Subscription] = []
    private let persistence: SubscriptionsStore
    
    init(persistence: SubscriptionsStore) {
        self.persistence = persistence
    }
    
    func loadSubscriptions() {
        subscriptions = persistence.loadSubscriptions()
    }
    
    func addSubscription(_ subscription: Subscription) {
        subscriptions.append(subscription)
        persistence.saveSubscriptions(subscriptions)
    }
    
    func deleteSubscription(_ indexSet: IndexSet) {
        subscriptions.remove(atOffsets: indexSet)
        persistence.saveSubscriptions(subscriptions)
    }
}
