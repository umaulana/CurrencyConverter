//
//  CurrencyConverterPresenterTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 28/01/23.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift

final class CurrencyConverterPresenterTests: QuickSpec {
    override func spec() {
        var presenter: CurrencyConverterPresenter!
        let mockCurrencyConverterInteractor = MockCurrencyConverterInteractor()
        let mockCurrencyConverterCoreDataInteractor = MockCurrencyConverterCoreDataInteractor()
        var disposeBag = DisposeBag()
        
        describe("CurrencySelectionPresenterTests") {
            let response = CurrencyRatesViewParam(rates: ["USD": 1.0, "IDR": 4.0, "INR": 8.0])
            
            afterEach {
                disposeBag = DisposeBag()
            }
            
            beforeEach {
                clearInvocations(mockCurrencyConverterInteractor)
                clearStubs(mockCurrencyConverterInteractor)
                clearInvocations(mockCurrencyConverterCoreDataInteractor)
                clearStubs(mockCurrencyConverterCoreDataInteractor)
                presenter = CurrencyConverterPresenter(currencyConverterInteractor: mockCurrencyConverterInteractor,
                                                       currencyConverterCoreDataInteractor: mockCurrencyConverterCoreDataInteractor)
            }
            
            context("loadRates called") {
                var isButtonActive = false
                
                beforeEach {
                    stub(mockCurrencyConverterCoreDataInteractor) { stub in
                        when(stub).saveRates(viewParam: any()).thenDoNothing()
                        when(stub).saveLastRatesRequest(date: any()).thenDoNothing()
                    }
                    
                    presenter.rxEventToggleselectCurrencyButton
                        .subscribe(onNext: { isActive in
                            isButtonActive = isActive
                        }).disposed(by: disposeBag)
                }
                
                context("saveLastRatesRequest succeed") {
                    context("dates difference is more than 30 minutes") {
                        beforeEach {
                            stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                when(stub).loadLastRatesRequest().thenReturn(.just(Date(timeIntervalSince1970: 0)))
                            }
                        }
                        
                        context("requestNewRates succeed") {
                            beforeEach {
                                stub(mockCurrencyConverterInteractor) { stub in
                                    when(stub).loadRates().thenReturn(.just(response))
                                }
                                
                                presenter.loadRates()
                            }
                            
                            it("should activate select currency button") {
                                expect(isButtonActive).to(beTrue())
                            }
                            
                            it("should call loadRates") {
                                verify(mockCurrencyConverterInteractor, times(1)).loadRates()
                            }
                        }
                        
                        context("requestNewRates error") {
                            let error = NSError(domain: "domain", code: 0)
                            beforeEach {
                                stub(mockCurrencyConverterInteractor) { stub in
                                    when(stub).loadRates().thenReturn(.error(error))
                                }
                                
                                presenter.loadRates()
                            }
                            
                            it("should show request error") {
                                let errorParam = CurrencyCellViewParam(symbol: "ERR", value: "An error has occured (Tap here to retry)")
                                expect(presenter.cellViewParams.value).to(equal([errorParam]))
                            }
                            
                            it("should deactivate select currency button") {
                                expect(isButtonActive).to(beFalse())
                            }
                        }
                    }
                    
                    context("dates difference is less than 30 minutes") {
                        beforeEach {
                            stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                when(stub).loadLastRatesRequest().thenReturn(.just(Date()))
                            }
                        }
                        
                        context("getSymbolsFromStorage is empty") {
                            beforeEach {
                                stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                    when(stub).loadRates().thenReturn(.just(.init(rates: [:])))
                                }
                                
                                stub(mockCurrencyConverterInteractor) { stub in
                                    when(stub).loadRates().thenReturn(.just(response))
                                }
                                
                                presenter.loadRates()
                            }
                            
                            it("should call loadRates") {
                                verify(mockCurrencyConverterInteractor, times(1)).loadRates()
                            }
                        }
                        
                        context("getSymbolsFromStorage is not empty") {
                            beforeEach {
                                stub(mockCurrencyConverterCoreDataInteractor) { stub in
                                    when(stub).loadRates().thenReturn(.just(response))
                                }
                                
                                presenter.loadRates()
                            }
                            
                            it("should activate select currency button") {
                                expect(isButtonActive).to(beTrue())
                            }
                        }
                    }
                }
                
                context("loadLastRatesRequest error") {
                    let error = NSError(domain: "domain", code: 0)
                    beforeEach {
                        stub(mockCurrencyConverterCoreDataInteractor) { stub in
                            when(stub).loadLastRatesRequest().thenReturn(.error(error))
                        }
                        
                        stub(mockCurrencyConverterInteractor) { stub in
                            when(stub).loadRates().thenReturn(.just(response))
                        }
                        
                        presenter.loadRates()
                    }
                    
                    it("should call loadRates") {
                        verify(mockCurrencyConverterInteractor, times(1)).loadRates()
                    }
                    
                    it("should activate select currency button") {
                        expect(isButtonActive).to(beTrue())
                    }
                }
            }
            
            context("retryRequest called") {
                beforeEach {
                    stub(mockCurrencyConverterInteractor) { stub in
                        when(stub).loadRates().thenReturn(.just(response))
                    }
                    
                    stub(mockCurrencyConverterCoreDataInteractor) { stub in
                        when(stub).saveRates(viewParam: any()).thenDoNothing()
                        when(stub).saveLastRatesRequest(date: any()).thenDoNothing()
                    }
                    
                    presenter.retryRequest()
                }
                
                it("should show empty data") {
                    expect(presenter.cellViewParams.value.isEmpty).to(beTrue())
                }
                
                it("should call loadRates") {
                    verify(mockCurrencyConverterInteractor, times(1)).loadRates()
                }
            }
            
            context("currencyDidChanged called") {
                let viewParam = CurrencyCellViewParam(symbol: "USD", value: "US")
                let expectation = self.expectation(description: "reset text field called")
                var currencyButtonText = ""
                
                beforeEach {
                    presenter.rxEventUpdateButtonText
                        .subscribe(onNext: { text in
                            currencyButtonText = text
                        }).disposed(by: disposeBag)
                    
                    presenter.currencyDidChanged(with: viewParam)
                }
                
                it("should call resetTextField") {
                    presenter.rxEventResetTextField
                        .subscribe(onNext: { _ in
                            expectation.fulfill()
                        }).disposed(by: disposeBag)
                    presenter.currencyDidChanged(with: viewParam)
                    self.wait(for: [expectation], timeout: 1)
                }
                
                it("should show empty data") {
                    expect(presenter.cellViewParams.value.isEmpty).to(beTrue())
                }
                
                it("should show correct button text") {
                    expect(currencyButtonText).to(equal(viewParam.toCurrencyButtonText()))
                }
            }
            
            context("convertCurrency called") {
                beforeEach {
                    stub(mockCurrencyConverterCoreDataInteractor) { stub in
                        when(stub).loadRates().thenReturn(.just(response))
                        when(stub).loadLastRatesRequest().thenReturn(.just(Date()))
                    }
                    
                    presenter.loadRates()
                    presenter.currencyDidChanged(with: .init(symbol: "IDR", value: "Indonesia"))
                    presenter.convertCurrency("2.0")
                }
                
                it("should show correct data") {
                    let expectedValues = [CurrencyCellViewParam(symbol: "IDR", value: "2.0"),
                                          CurrencyCellViewParam(symbol: "INR", value: "4.0"),
                                          CurrencyCellViewParam(symbol: "USD", value: "0.5")]
                    
                    expect(presenter.cellViewParams.value).to(equal(expectedValues))
                }
            }
        }
    }
}
