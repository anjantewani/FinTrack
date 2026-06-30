//
//  LocalSubscriptionsStore.swift
//  FinTrack
//
//  Created by Anjan Tewani on 04/05/26.
//

import Foundation

class LocalSubscriptionsStore: SubscriptionsStore {
    let fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
        
    func loadSubscriptions() -> [Subscription] {
        if !FileManager.default.fileExists(atPath: fileURL.path()) {
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Subscription].self, from: data)
        } catch {
            print(String(describing: error))
            return []
        }
    }
    
    func saveSubscriptions(_ subscriptions: [Subscription]) {
        do {
            let jsonData = try JSONEncoder().encode(subscriptions)
            try jsonData.write(to: fileURL, options: .atomic)
        } catch {
            print(String(describing: error))
        }
    }
}
