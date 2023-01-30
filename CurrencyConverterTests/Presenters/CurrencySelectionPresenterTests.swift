//
//  CurrencySelectionPresenterTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 28/01/23.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift

final class CurrencySelectionPresenterTests: QuickSpec {
    override func spec() {
        var presenter: CurrencySelectionPresenter!
        let mockCurrencyConverterInteractor = MockCurrencyConverterInteractor()
        let mockCurrencyConverterCoreDataInteractor = MockCurrencyConverterCoreDataInteractor()
        var disposeBag = DisposeBag()
        
        describe("CurrencySelectionPresenterTests") {
            let response = CurrencySymbolsViewParam(symbols: [(name: "INDIA", "INR"), (name: "USA", "USD")])
            let viewParam = CurrencyCellViewParam(symbol: "IDR", value: "1.0")
            let errorViewParam = CurrencyCellViewParam(symbol: "ERR", value: "An error has occured (Tap here to retry)")
            
            afterEach {
                disposeBag = DisposeBag()
            }
            
            beforeEach {
                clearInvocations(mockCurrencyConverterInteractor)
                clearStubs(mockCurrencyConverterInteractor)
                clearInvocations(mockCurrencyConverterCoreDataInteractor)
                clearStubs(mockCurrencyConverterCoreDataInteractor)
                presenter = CurrencySelectionPresenter(currencyConverterInteractor: mockCurrencyConverterInteractor,
                                                       currencyConverterCoreDataInteractor: mockCurrencyConverterCoreDataInteractor)
            }
            
            context("loadSymbols called") {
                beforeEach {
                    stub(mockCurrencyConverterCoreDataInteractor) { stub in
                        when(stub).saveSymbols(viewParam: any()).thenDoNothing()
                        when(stub).saveLastSymbolsRequest(date: any()).thenDoNothing()
                    }
                }
                
                context("loadLastSymbolsRequest succeed") {
                    var isTextFieldActive = false
                    
                    context("dates difference is more than 30 minutes") {
                        beforeEach {
                            stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                when(stub).loadLastSymbolsRequest().thenReturn(.just(Date(timeIntervalSince1970: 0)))
                            }
                            
                            presenter.rxEventToggleTextFieldInteraction
                                .subscribe(onNext: { isActive in
                                    isTextFieldActive = isActive
                                }).disposed(by: disposeBag)
                        }
                        
                        context("requestNewSymbols succeed") {
                            beforeEach {
                                stub(mockCurrencyConverterInteractor) { stub in
                                    when(stub).loadSymbols().thenReturn(.just(response))
                                }
                                
                                presenter.loadSymbols()
                            }
                            
                            it("should show correct data") {
                                expect(presenter.cellViewParams.value).to(equal(response.toCurrencyCellViewParam()))
                            }
                            
                            it("should activate text field") {
                                expect(isTextFieldActive).to(beTrue())
                            }
                        }
                        
                        context("requestNewSymbols error") {
                            let error = NSError(domain: "domain", code: 0)
                            beforeEach {
                                stub(mockCurrencyConverterInteractor) { stub in
                                    when(stub).loadSymbols().thenReturn(.error(error))
                                }
                                
                                presenter.loadSymbols()
                            }
                            
                            it("should show request error") {
                                let errorParam = CurrencyCellViewParam(symbol: "ERR", value: "An error has occured (Tap here to retry)")
                                expect(presenter.cellViewParams.value).to(equal([errorParam]))
                            }
                            
                            it("should deactivate text field") {
                                expect(isTextFieldActive).to(beFalse())
                            }
                        }
                    }
                    
                    context("dates difference is less than 30 minutes") {
                        beforeEach {
                            stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                when(stub).loadLastSymbolsRequest().thenReturn(.just(Date()))
                            }
                        }
                        
                        context("getSymbolsFromStorage is empty") {
                            beforeEach {
                                stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                    when(stub).loadSymbols().thenReturn(.just(.init(symbols: [])))
                                }
                                
                                stub(mockCurrencyConverterInteractor) { stub in
                                    when(stub).loadSymbols().thenReturn(.just(response))
                                }
                                
                                presenter.loadSymbols()
                            }
                            
                            it("should call requestNewSymbols") {
                                verify(mockCurrencyConverterInteractor, times(1)).loadSymbols()
                            }
                        }
                        
                        context("getSymbolsFromStorage is not empty") {
                            beforeEach {
                                stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                    when(stub).loadSymbols().thenReturn(.just(response))
                                }
                                
                                presenter.loadSymbols()
                            }
                            
                            it("should show correct data") {
                                expect(presenter.cellViewParams.value).to(equal(response.toCurrencyCellViewParam()))
                            }
                        }
                    }
                }
                
                context("loadLastSymbolsRequest error") {
                    let error = NSError(domain: "domain", code: 0)
                    beforeEach {
                        stub(mockCurrencyConverterCoreDataInteractor) { stub in
                            when(stub).loadLastSymbolsRequest().thenReturn(.error(error))
                        }
                        
                        stub(mockCurrencyConverterInteractor) { stub in
                            when(stub).loadSymbols().thenReturn(.just(response))
                        }
                        
                        presenter.loadSymbols()
                    }
                    
                    it("should call requestNewSymbols") {
                        verify(mockCurrencyConverterInteractor, times(1)).loadSymbols()
                    }
                }
            }
            
            context("filterSymbols called") {
                beforeEach {
                    stub(mockCurrencyConverterCoreDataInteractor) { stub in
                        when(stub).loadLastSymbolsRequest().thenReturn(.just(Date()))
                        when(stub).loadSymbols().thenReturn(.just(response))
                    }
                    presenter.loadSymbols()
                    presenter.filterSymbols(with: "US")
                }
                
                it("should show correct data") {
                    expect(presenter.cellViewParams.value.count).to(equal(1))
                }
            }
            
            context("didSelectRow called") {
                var eventParam: CurrencyCellViewParam!
                beforeEach {
                    stub(mockCurrencyConverterInteractor) { stub in
                        when(stub).loadSymbols().thenReturn(.just(.init(symbols: [])))
                    }
                    
                    stub(mockCurrencyConverterCoreDataInteractor) { stub in
                        when(stub).saveLastSymbolsRequest(date: any()).thenDoNothing()
                        when(stub).saveSymbols(viewParam: any()).thenDoNothing()
                    }
                    
                    presenter.rxEventDidSelectRow.subscribe(onNext: { param in
                        eventParam = param
                    }).disposed(by: disposeBag)
                }
                
                context("symbol is ERR") {
                    beforeEach {
                        clearInvocations(mockCurrencyConverterInteractor)
                        presenter.didSelectRow(viewParam: errorViewParam)
                    }
                    
                    it("should retry loadSymbols request") {
                        verify(mockCurrencyConverterInteractor, times(1)).loadSymbols()
                    }
                    
                    it("should show empty cells") {
                        expect(presenter.cellViewParams.value.isEmpty).to(beTrue())
                    }
                }
                
                context("symbol is not ERR") {
                    beforeEach {
                        presenter.didSelectRow(viewParam: viewParam)
                    }
                    
                    it("should send rxEventDidSelectRow with correct data") {
                        expect(eventParam).to(equal(viewParam))
                    }
                }
            }
        }
    }
}
