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
    private let currencyConverterCoreDataInteractor:  CurrencyConverterCoreDataInteractor
    
    init(currencyConverterInteractor:  CurrencyConverterInteractor,
         currencyConverterCoreDataInteractor:  CurrencyConverterCoreDataInteractor) {
        self.currencyConverterInteractor = currencyConverterInteractor
        self.currencyConverterCoreDataInteractor = currencyConverterCoreDataInteractor
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
        self.currencyConverterCoreDataInteractor.loadLastRatesRequest()
            .subscribe(onNext: { [weak self] date in
                if date.is30MinutesDifferent(from: Date()) {
                    self?.requestNewRates()
                } else {
                    self?.getRatesFromStorage()
                }
            }, onError: { [weak self] error in
                self?.requestNewRates()
            }).disposed(by: disposeBag)
    }
    
    private func getRatesFromStorage() {
        self.currencyConverterCoreDataInteractor.loadRates()
            .subscribe(onNext: { [weak self] viewParam in
                guard !viewParam.rates.isEmpty else {
                    self?.requestNewRates()
                    return
                }
                
                self?.rates = viewParam.rates
            }).disposed(by: disposeBag)
    }
    
    private func requestNewRates() {
        self.currencyConverterInteractor.loadRates()
            .subscribe(onNext: { [weak self] viewParam in
                self?.rates = viewParam.rates
                self?.currencyConverterCoreDataInteractor.saveRates(viewParam: viewParam)
                self?.currencyConverterCoreDataInteractor.saveLastRatesRequest(date: Date())
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
