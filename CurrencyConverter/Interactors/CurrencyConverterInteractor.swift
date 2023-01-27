//
//  CurrencyInteractor.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation
import RxSwift

protocol CurrencyConverterInteractor {
    func loadRates() -> Observable<CurrencyRatesViewParam>
    func loadSymbols() -> Observable<CurrencySymbolsViewParam>
}
