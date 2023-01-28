//
//  Date+Extensions.swift
//  CurrencyConverter
//
//  Created by umam on 28/01/23.
//

import Foundation

extension Date {
    func is30MinutesDifferent(from newDate: Date) -> Bool {
        guard let minutes = Calendar.current.dateComponents([.minute], from: newDate, to: self).minute else {
            return false
        }
        
        return abs(minutes) >= 30
    }
}
