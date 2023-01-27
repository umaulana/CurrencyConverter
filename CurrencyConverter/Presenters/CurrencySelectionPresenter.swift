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
    
    private let eventDidSelectRow = PublishSubject<CurrencyCellViewParam>()
    var rxEventDidSelectRow: Observable<CurrencyCellViewParam> {
        return eventDidSelectRow
    }
    private let disposeBag = DisposeBag()
    
    private(set) var cellViewParams = BehaviorRelay<[CurrencyCellViewParam]>(value: [])
    private var symbols: [(name: String, symbol: String)] = []
    
    init(currencyConverterInteractor:  CurrencyConverterInteractor) {
        self.currencyConverterInteractor = currencyConverterInteractor
    }
    
    func loadSymbols() {
        self.currencyConverterInteractor.loadSymbols()
            .subscribe(onNext: { [weak self] viewParam in
                self?.symbols = viewParam.symbols
                
                self?.cellViewParams.accept(viewParam.symbols.map { CurrencyCellViewParam(symbol: $0.symbol,
                                                                                          value: $0.name)})
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func filterSymbols(with text: String) {
        let text = text.lowercased()
        let filteredSymbols = symbols.filter { (name, symbol) in
            return name.lowercased().hasPrefix(text) || symbol.lowercased().hasPrefix(text)
        }.map { CurrencyCellViewParam(symbol: $0.symbol, value: $0.name)}
        
        cellViewParams.accept(filteredSymbols)
    }
    
    func didSelectRow(viewParam: CurrencyCellViewParam) {
        eventDidSelectRow.onNext(viewParam)
    }
}


