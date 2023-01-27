//
//  CurrencyCellViewParam.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation

struct CurrencyCellViewParam {
    let symbol: String
    let value: String
}

extension CurrencyCellViewParam: Comparable {
    static func < (lhs: CurrencyCellViewParam, rhs: CurrencyCellViewParam) -> Bool {
        return lhs.symbol < rhs.symbol
    }
}
