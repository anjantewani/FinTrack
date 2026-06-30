//
//  Subscription.swift
//  FinTrack
//
//  Created by Anjan Tewani on 22/04/26.
//

import Foundation

struct Subscription: Identifiable, Codable {
    let id: UUID
    let name: String
    let amount: Double
    let nextBillingDate: Date
    let billingCycle: BillingCycle
}
