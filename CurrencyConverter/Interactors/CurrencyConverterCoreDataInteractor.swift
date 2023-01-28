//
//  CurrencyConverterCoreDataInteractor.swift
//  CurrencyConverter
//
//  Created by umam on 28/01/23.
//

import Foundation
import RxSwift

protocol CurrencyConverterCoreDataInteractor {
    func loadRates() -> Observable<CurrencyRatesViewParam>
    func loadSymbols() -> Observable<CurrencySymbolsViewParam>
    func saveRates(viewParam: CurrencyRatesViewParam) -> Void
    func saveSymbols(viewParam: CurrencySymbolsViewParam) -> Void
    
    func loadLastRatesRequest() -> Observable<Date>
    func loadLastSymbolsRequest() -> Observable<Date>
    func saveLastRatesRequest(date: Date) -> Void
    func saveLastSymbolsRequest(date: Date) -> Void
}
