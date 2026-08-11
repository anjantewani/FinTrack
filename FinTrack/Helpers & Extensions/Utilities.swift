//
//  Utilities.swift
//  FinTrack
//
//  Created by Anjan Tewani on 04/07/26.
//

import Foundation

struct Utilities {
    static let shared = Utilities()
    
    func previousMonthTotalExpense(expenses: [Expense]) -> Double {
        var calendar = Calendar.current
        calendar.timeZone = .autoupdatingCurrent

        var previousTotal: Double = 0
        
        expenses.forEach({ expense in
            guard let previousMonth = calendar.date(byAdding: DateComponents(month: -1), to: .now) else { return }
            if calendar.isDate(expense.date, equalTo: previousMonth, toGranularity: .month) {
                previousTotal += expense.amount
            }
        })
        
        return previousTotal
    }
    
    func currentMonthTotalExpense(expenses: [Expense]) -> Double {
        var calendar = Calendar.current
        calendar.timeZone = .autoupdatingCurrent

        var currentTotal: Double = 0

        expenses.forEach({ expense in
            if calendar.isDate(expense.date, equalTo: .now, toGranularity: .month) {
                currentTotal += expense.amount
            }
        })
        
        return currentTotal
    }
    
    func expensePercentAgainstPreviousMonth(expenses: [Expense]) -> Double {
        var calendar = Calendar.current
        calendar.timeZone = .autoupdatingCurrent
        
        let currentTotal = currentMonthTotalExpense(expenses: expenses)
        let previousTotal = previousMonthTotalExpense(expenses: expenses)
                
        // Using (current - previous) for percentage difference relative to the previous total.
        // Positive percentage indicates more spending than the previous month.
        return (currentTotal - previousTotal) * 100 / previousTotal
    }
}
