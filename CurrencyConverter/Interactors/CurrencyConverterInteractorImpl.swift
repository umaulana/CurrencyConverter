//
//  CurrencyConverterInteractorImpl.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation
import RxSwift

class CurrencyConverterInteractorImpl: CurrencyConverterInteractor {
    let currencyConverterApi: CurrencyConverterApi
    
    init(currencyConverterApi: CurrencyConverterApi) {
        self.currencyConverterApi = currencyConverterApi
    }
    
    func loadRates() -> Observable<CurrencyRatesViewParam> {
        return currencyConverterApi.loadRates().map { $0.toCurrencyRatesViewParam() }
    }
    
    func loadSymbols() -> Observable<CurrencySymbolsViewParam> {
        return currencyConverterApi.loadSymbols().map { $0.toCurrencySymbolsViewParam() }
    }
}
