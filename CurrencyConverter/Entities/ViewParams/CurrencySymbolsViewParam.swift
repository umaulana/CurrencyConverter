//
//  CurrencySymbolsViewParam.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation

struct CurrencySymbolsViewParam {
    let symbols: [(name: String, symbol: String)]
}

extension CurrencySymbolsViewParam {
    func toCurrencyCellViewParam() -> [CurrencyCellViewParam] {
        self.symbols.map { CurrencyCellViewParam(symbol: $0.symbol, value: $0.name)}
    }
}

extension CurrencySymbolsViewParam: Equatable {
    static func == (lhs: CurrencySymbolsViewParam, rhs: CurrencySymbolsViewParam) -> Bool {
        for (lhsSymbols, rhsSymbols) in zip(lhs.symbols, rhs.symbols) {
            if lhsSymbols.name != rhsSymbols.name || lhsSymbols.symbol != lhsSymbols.symbol {
                return false
            }
        }
        return true
    }
}
