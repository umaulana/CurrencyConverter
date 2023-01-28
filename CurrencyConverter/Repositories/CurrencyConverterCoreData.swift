//
//  CurrencyConverterCoreData.swift
//  CurrencyConverter
//
//  Created by umam on 28/01/23.
//

import Foundation
import RxSwift

protocol CurrencyConverterCoreData {
    func loadRates() -> Observable<CurrencyRates>
    func loadSymbols() -> Observable<CurrencySymbols>
    func saveRates(viewParam: CurrencyRatesViewParam) -> Void
    func saveSymbols(viewParam: CurrencySymbolsViewParam) -> Void
    
    func loadLastRatesRequest() -> Observable<Date>
    func loadLastSymbolsRequest() -> Observable<Date>
    func saveLastRatesRequest(date: Date) -> Void
    func saveLastSymbolsRequest(date: Date) -> Void
}

