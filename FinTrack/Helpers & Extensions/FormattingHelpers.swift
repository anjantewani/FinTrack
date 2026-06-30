//
//  FormattingHelpers.swift
//  FinTrack
//
//  Created by Anjan Tewani on 22/06/26.
//

import Foundation

struct FormattingHelpers {
    static let shared = FormattingHelpers()
    
    func dateFormatter(for date: Date, with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
