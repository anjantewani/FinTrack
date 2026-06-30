//
//  SubscriptionsViewModel.swift
//  FinTrack
//
//  Created by Anjan Tewani on 11/05/26.
//

import Foundation
import Combine

enum SubscriptionsViewState {
    case loading
    case empty
    case loaded
    case error
}

class SubscriptionsViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let store: SubscriptionStore
    var subscriptions: [Subscription] {
        store.subscriptions
    }
    @Published var state: SubscriptionsViewState = .empty
    
    init(store: SubscriptionStore) {
        self.store = store
        
        store.$subscriptions
            .sink { [weak self] subscriptions in
                guard let self = self else { return }
                self.state = subscriptions.isEmpty ? .empty : .loaded
            }
            .store(in: &cancellables)
    }
    
    func loadSubscriptions() {
        state = .loading
        store.loadSubscriptions()
    }
    
    func addSubscriptionTapped(withName: String, withAmount: String, withBillingCycle: BillingCycle) {
        guard let amount = Double(withAmount), let nextBillingDate = withBillingCycle.nextDate(from: .now) else { return }
        
        let subscription = Subscription(id: UUID(), name: withName, amount: amount, nextBillingDate: nextBillingDate, billingCycle: withBillingCycle)
        
        store.addSubscription(subscription)
    }
    
    func deleteSubscriptions(withIndexes: IndexSet) {
        store.deleteSubscription(withIndexes)
    }
    
    func checkAddButtonEnability(withName: String, withAmount: String) -> Bool {
        var enableAddButton = false
        if let _ = Double(withAmount) {
            if !withName.isEmpty {
                enableAddButton = true
            }
        }
        return enableAddButton
    }
}
