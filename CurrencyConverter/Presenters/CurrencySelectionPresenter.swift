//
//  CurrencySelectionPresenter.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Foundation
import RxSwift
import RxRelay

class CurrencySelectionPresenter {
    private let currencyConverterInteractor:  CurrencyConverterInteractor
    private let currencyConverterCoreDataInteractor:  CurrencyConverterCoreDataInteractor
    
    init(currencyConverterInteractor:  CurrencyConverterInteractor,
         currencyConverterCoreDataInteractor:  CurrencyConverterCoreDataInteractor) {
        self.currencyConverterInteractor = currencyConverterInteractor
        self.currencyConverterCoreDataInteractor = currencyConverterCoreDataInteractor
    }
    
    private let eventDidSelectRow = PublishSubject<CurrencyCellViewParam>()
    var rxEventDidSelectRow: Observable<CurrencyCellViewParam> {
        return eventDidSelectRow
    }
    private let eventToggleTextFieldInteraction = PublishSubject<Bool>()
    var rxEventToggleTextFieldInteraction: Observable<Bool> {
        return eventToggleTextFieldInteraction
    }
    
    private let disposeBag = DisposeBag()
    
    private(set) var cellViewParams = BehaviorRelay<[CurrencyCellViewParam]>(value: [])
    private var symbols: [(name: String, symbol: String)] = []
    
    func loadSymbols() {
        self.currencyConverterCoreDataInteractor.loadLastSymbolsRequest()
            .subscribe(onNext: { [weak self] date in
                if date.is30MinutesDifferent(from: Date()) {
                    self?.requestNewSymbols()
                } else {
                    self?.getSymbolsFromStorage()
                }
            }, onError: { [weak self] error in
                self?.requestNewSymbols()
            }).disposed(by: disposeBag)
    }
    
    private func getSymbolsFromStorage() {
        self.currencyConverterCoreDataInteractor.loadSymbols()
            .subscribe(onNext: { [weak self] viewParam in
                guard !viewParam.symbols.isEmpty else {
                    self?.requestNewSymbols()
                    return
                }
                
                self?.symbols = viewParam.symbols
                self?.cellViewParams.accept(viewParam.symbols.map { CurrencyCellViewParam(symbol: $0.symbol,
                                                                                          value: $0.name)})
            }).disposed(by: disposeBag)
    }
    
    private func requestNewSymbols() {
        self.currencyConverterInteractor.loadSymbols()
            .subscribe(onNext: { [weak self] viewParam in
                self?.symbols = viewParam.symbols
                
                self?.cellViewParams.accept(viewParam.symbols.map { CurrencyCellViewParam(symbol: $0.symbol,
                                                                                          value: $0.name)})
                self?.eventToggleTextFieldInteraction.onNext(true)
                
                self?.currencyConverterCoreDataInteractor.saveSymbols(viewParam: viewParam)
                self?.currencyConverterCoreDataInteractor.saveLastSymbolsRequest(date: Date())
            }, onError: { [weak self] error in
                self?.showRequestError()
            }).disposed(by: disposeBag)
    }
    
    private func showRequestError() {
        let errorParam = CurrencyCellViewParam(symbol: "ERR", value: "An error has occured (Tap here to retry)")
        cellViewParams.accept([errorParam])
        
        eventToggleTextFieldInteraction.onNext(false)
    }
    
    private func retryRequest() {
        cellViewParams.accept([])
        
        requestNewSymbols()
    }
    
    func filterSymbols(with text: String) {
        let text = text.lowercased()
        let filteredSymbols = symbols.filter { (name, symbol) in
            return name.lowercased().hasPrefix(text) || symbol.lowercased().hasPrefix(text)
        }.map { CurrencyCellViewParam(symbol: $0.symbol, value: $0.name)}
        
        cellViewParams.accept(filteredSymbols)
    }
    
    func didSelectRow(viewParam: CurrencyCellViewParam) {
        guard viewParam.symbol != "ERR" else {
            retryRequest()
            return
        }
        
        eventDidSelectRow.onNext(viewParam)
    }
}
