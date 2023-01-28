//
//  CurrencyConverterCoreDataInteractorImpl.swift
//  CurrencyConverter
//
//  Created by umam on 28/01/23.
//

import Foundation
import RxSwift

class CurrencyConverterCoreDataInteractorImpl: CurrencyConverterCoreDataInteractor {
    let currencyConverterCoreData: CurrencyConverterCoreData
    
    init(currencyConverterCoreData: CurrencyConverterCoreData) {
        self.currencyConverterCoreData = currencyConverterCoreData
    }
    
    func loadRates() -> Observable<CurrencyRatesViewParam> {
        return self.currencyConverterCoreData.loadRates().map { $0.toCurrencyRatesViewParam() }
    }
    
    func loadSymbols() -> Observable<CurrencySymbolsViewParam> {
        return self.currencyConverterCoreData.loadSymbols().map { $0.toCurrencySymbolsViewParam() }
    }
    
    func saveRates(viewParam: CurrencyRatesViewParam) {
        self.currencyConverterCoreData.saveRates(viewParam: viewParam)
    }
    
    func saveSymbols(viewParam: CurrencySymbolsViewParam) {
        self.currencyConverterCoreData.saveSymbols(viewParam: viewParam)
    }
    
    func loadLastRatesRequest() -> Observable<Date> {
        return self.currencyConverterCoreData.loadLastRatesRequest()
    }
    
    func loadLastSymbolsRequest() -> Observable<Date> {
        return self.currencyConverterCoreData.loadLastSymbolsRequest()
    }
    
    func saveLastRatesRequest(date: Date) {
        self.currencyConverterCoreData.saveLastRatesRequest(date: date)
    }
    
    func saveLastSymbolsRequest(date: Date) {
        self.currencyConverterCoreData.saveLastSymbolsRequest(date: date)
    }
}
