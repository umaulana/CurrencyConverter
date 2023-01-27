//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation
import RxSwift

class CurrencyConverterPresenter {
    private let currencyConverterInteractor:  CurrencyConverterInteractor
    
    private let disposeBag = DisposeBag()
    
    init(currencyConverterInteractor:  CurrencyConverterInteractor) {
        self.currencyConverterInteractor = currencyConverterInteractor
    }
    
    func loadRates() {
        self.currencyConverterInteractor.loadRates()
            .subscribe(onNext: { viewParam in
                print(viewParam)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        
        self.currencyConverterInteractor.loadSymbols()
            .subscribe(onNext: { viewParam in
                print(viewParam)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
