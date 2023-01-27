//
//  CurrencyConverterApi.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation
import RxSwift

protocol CurrencyConverterApi {
    func loadRates() -> Observable<CurrencyRates>
    func loadSymbols() -> Observable<CurrencySymbols>
}
