//
//  CurrencySymbolsTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 30/01/23.
//

import Nimble
import Quick
import XCTest

final class CurrencySymbolsTests: QuickSpec {
    override func spec() {
        describe("CurrencySymbols Model") {
            
            context("when tranforming into CurrencySymbolsViewParam") {
                it("should return the sorted symbols") {
                    let currencySymbols = CurrencySymbols(symbols: [
                        "bca": "bca",
                        "abc": "abc"
                    ])
                    
                    let currencySymbolsViewParam = CurrencySymbolsViewParam(symbols: [
                        (name: "abc", symbol: "abc"),
                        (name: "bca", symbol: "bca")
                    ])
                    
                    expect(currencySymbols.toCurrencySymbolsViewParam())
                        .to(equal(currencySymbolsViewParam))
                }
            }
            
        }
    }
}
