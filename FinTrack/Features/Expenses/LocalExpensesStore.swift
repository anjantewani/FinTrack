//
//  LocalExpensesStore.swift
//  FinTrack
//
//  Created by Anjan Tewani on 12/03/26.
//

import Foundation

class LocalExpensesStore: ExpensesStore {
    let fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    func loadExpenses() -> [Expense] {
        if !FileManager.default.fileExists(atPath: fileURL.path()) {
            return []
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let expenses = try JSONDecoder().decode([Expense].self, from: data)
            return expenses
        } catch {
            print(String(describing: error))
            return []
        }
    }
    
    func saveExpenses(_ expenses: [Expense]) {
        do {
            let jsonData = try JSONEncoder().encode(expenses)
            try jsonData.write(to: fileURL, options: .atomic)
        } catch {
            print(String(describing: error))
        }
    }
}
