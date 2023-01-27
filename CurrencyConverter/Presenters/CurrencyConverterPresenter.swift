//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation
import RxSwift
import RxRelay

class CurrencyConverterPresenter {
    private let currencyConverterInteractor:  CurrencyConverterInteractor
    
    init(currencyConverterInteractor:  CurrencyConverterInteractor) {
        self.currencyConverterInteractor = currencyConverterInteractor
    }
    
    private let eventUpdateButtonText = PublishSubject<String>()
    var rxEventUpdateButtonText: Observable<String> {
        return eventUpdateButtonText
    }
    private let eventResetTextField = PublishSubject<Void>()
    var rxEventResetTextField: Observable<Void> {
        return eventResetTextField
    }
    private let disposeBag = DisposeBag()
    
    private(set) var cellViewParams = BehaviorRelay<[CurrencyCellViewParam]>(value: [])
    private var rates: [String: Double] = [:]
    private var selectedCurrency: CurrencyCellViewParam?
    
    func loadRates() {
        self.currencyConverterInteractor.loadRates()
            .subscribe(onNext: { [weak self] viewParam in
                self?.rates = viewParam.rates
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func currencyDidChanged(with viewParam: CurrencyCellViewParam) {
        selectedCurrency = viewParam
        
        let buttonText = "(\(viewParam.symbol)) - \(viewParam.value)"
        eventUpdateButtonText.onNext(buttonText)
        eventResetTextField.onNext(())
        cellViewParams.accept([])
    }
    
    func convertCurrency(_ text: String) {
        guard let amount = Double(text.addZeroIfNecessary),
              let selectedCurrency = self.selectedCurrency
        else { return }
        
        let params = rates.map { (key, value) in
            let rate = getRate(amount: amount,
                               selectedCurrency: selectedCurrency.symbol,
                               currentRate: value)
            return CurrencyCellViewParam(symbol: key, value: rate)
        }.sorted()
        
        cellViewParams.accept(params)
    }
    
    private func getRate(amount: Double,
                         selectedCurrency: String,
                         currentRate: Double) -> String {
        guard let selectedRate = rates[selectedCurrency] else { return "" }
        
        let rateInUSD = amount / selectedRate
        let rateInCurrentCurrency = rateInUSD * currentRate
        return "\(rateInCurrentCurrency)"
    }
}
