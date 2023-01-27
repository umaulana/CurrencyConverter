//
//  CurrencyRates.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation

struct CurrencyRates {
    let rates: [String: Double]
}

extension CurrencyRates {
    func toCurrencyRatesViewParam() -> CurrencyRatesViewParam {
        return CurrencyRatesViewParam(rates: self.rates)
    }
}
