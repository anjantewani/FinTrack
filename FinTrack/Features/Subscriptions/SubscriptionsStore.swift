//
//  SubscriptionsStore.swift
//  FinTrack
//
//  Created by Anjan Tewani on 22/04/26.
//

import Foundation

protocol SubscriptionsStore {
    func loadSubscriptions() -> [Subscription]
    func saveSubscriptions(_ subscriptions: [Subscription])
}
