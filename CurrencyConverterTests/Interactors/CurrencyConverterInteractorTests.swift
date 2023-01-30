//
//  CurrencyConverterInteractorTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 28/01/23.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift

final class CurrencyConverterInteractorTests: QuickSpec {
    override func spec() {
        var interactor: CurrencyConverterInteractorImpl!
        let mockCurrencyConverterApi = MockCurrencyConverterApi()
        
        describe("CurrencyConverterInteractorTests") {
            beforeEach {
                clearInvocations(mockCurrencyConverterApi)
                clearStubs(mockCurrencyConverterApi)
                interactor = CurrencyConverterInteractorImpl(currencyConverterApi: mockCurrencyConverterApi)
            }
            
            context("interactor calls loadRates succeed") {
                let currencyRates = CurrencyRates(rates: ["abc": 1.0, "bca": 2.0])
                var successData: CurrencyRatesViewParam!
                
                beforeEach {
                    stub(mockCurrencyConverterApi) { stub in
                        let successOutput = Observable.just(currencyRates)
                        when(stub).loadRates().thenReturn(successOutput)
                        successData = try! interactor.loadRates().toBlocking().first()!
                    }
                }
                
                it("should call loadRates in repository") {
                    verify(mockCurrencyConverterApi, times(1)).loadRates()
                }
                
                it("should get correct data") {
                    expect(successData.rates)
                        .to(equal(currencyRates.toCurrencyRatesViewParam().rates))
                }
            }
            
            context("interactor calls loadSymbols succeed") {
                let currencySymbols = CurrencySymbols(symbols: ["abc": "abc", "bca": "bca"])
                var successData: CurrencySymbolsViewParam!
                
                beforeEach {
                    stub(mockCurrencyConverterApi) { stub in
                        let successOutput = Observable.just(currencySymbols)
                        when(stub).loadSymbols().thenReturn(successOutput)
                        successData = try! interactor.loadSymbols().toBlocking().first()!
                    }
                }
                
                it("should call loadSymbols in repository") {
                    verify(mockCurrencyConverterApi, times(1)).loadSymbols()
                }
                
                it("should get correct data") {
                    expect(successData)
                        .to(equal(currencySymbols.toCurrencySymbolsViewParam()))
                }
            }
            
            context("interactor calls loadRates error") {
                let error = NSError(domain: "domain", code: 0)
                var errorData: NSError!
                
                beforeEach {
                    stub(mockCurrencyConverterApi) { stub in
                        when(stub).loadRates().thenReturn(.error(error))
                        do {
                            _ = try interactor.loadRates().toBlocking().first()
                        } catch let err as NSError {
                            errorData = err
                        }
                    }
                }
                
                it("should call loadRates in repository") {
                    verify(mockCurrencyConverterApi, times(1)).loadRates()
                }
                
                it("should get correct data") {
                    expect(errorData)
                        .to(equal(error))
                }
            }
            
            context("interactor calls loadSymbols error") {
                let error = NSError(domain: "domain", code: 0)
                var errorData: NSError!
                
                beforeEach {
                    stub(mockCurrencyConverterApi) { stub in
                        when(stub).loadSymbols().thenReturn(.error(error))
                        do {
                            _ = try interactor.loadSymbols().toBlocking().first()
                        } catch let err as NSError {
                            errorData = err
                        }
                    }
                }
                
                it("should call loadSymbols in repository") {
                    verify(mockCurrencyConverterApi, times(1)).loadSymbols()
                }
                
                it("should get correct data") {
                    expect(errorData)
                        .to(equal(error))
                }
            }
        }
        
    }
}
