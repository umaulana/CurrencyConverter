//
//  String+Extensions.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation

extension String {
    var addZeroIfNecessary: String {
        guard !self.isEmpty else { return "0" }
        
        var newString = self
        
        if let firstCharacter = self.first, firstCharacter == "." {
            newString = "0" + newString
        }
        
        if let lastCharacter = self.last, lastCharacter == "." {
            newString = newString + "0"
        }
        
        return newString
    }
}
