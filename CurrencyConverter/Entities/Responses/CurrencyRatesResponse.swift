//
//  CurrencyRatesResponse.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation

struct CurrencyRatesResponse: Decodable {
    var rates: [String: Double]?
}

extension CurrencyRatesResponse {
    func toCurrencyRates() -> CurrencyRates {
        return CurrencyRates(rates: self.rates ?? [:])
    }
}
