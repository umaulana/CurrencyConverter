//
//  CurrencySymbols.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation

struct CurrencySymbols {
    let symbols: [String: String]
}

extension CurrencySymbols {
    func toCurrencySymbolsViewParam() -> CurrencySymbolsViewParam {
        let symbols = self.symbols.map { (symbol, name) in
            return (name: name, symbol: symbol)
        }.sorted { $0.symbol < $1.symbol }
        
        return CurrencySymbolsViewParam(symbols: symbols)
    }
}
