//
//  CurrencyConverterCoreDataInteractorTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 28/01/23.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift

final class CurrencyConverterCoreDataInteractorTests: QuickSpec {
    override func spec() {
        var interactor: CurrencyConverterCoreDataInteractorImpl!
        let mockCurrencyConverterCoreData = MockCurrencyConverterCoreData()
        
        describe("CurrencyConverterCoreDataInteractorTests") {
            beforeEach {
                clearInvocations(mockCurrencyConverterCoreData)
                clearStubs(mockCurrencyConverterCoreData)
                interactor = CurrencyConverterCoreDataInteractorImpl(currencyConverterCoreData: mockCurrencyConverterCoreData)
            }
            
            context("interactor calls loadRates") {
                let currencyRates = CurrencyRates(rates: ["abc": 1.0, "bca": 2.0])
                var successData: CurrencyRatesViewParam!
                
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        let successOutput = Observable.just(currencyRates)
                        when(stub).loadRates().thenReturn(successOutput)
                        successData = try! interactor.loadRates().toBlocking().first()!
                    }
                }
                
                it("should call loadRates in repository") {
                    verify(mockCurrencyConverterCoreData, times(1)).loadRates()
                }
                
                it("should get correct data") {
                    expect(successData.rates)
                        .to(equal(currencyRates.toCurrencyRatesViewParam().rates))
                }
            }
            
            context("interactor calls loadSymbols") {
                let currencySymbols = CurrencySymbols(symbols: ["abc": "abc", "bca": "bca"])
                var successData: CurrencySymbolsViewParam!
                
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        let successOutput = Observable.just(currencySymbols)
                        when(stub).loadSymbols().thenReturn(successOutput)
                        successData = try! interactor.loadSymbols().toBlocking().first()!
                    }
                }
                
                it("should call loadSymbols in repository") {
                    verify(mockCurrencyConverterCoreData, times(1)).loadSymbols()
                }
                
                it("should get correct data") {
                    expect(successData)
                        .to(equal(currencySymbols.toCurrencySymbolsViewParam()))
                }
            }
            
            context("interactor calls saveRates") {
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).saveRates(viewParam: any()).thenDoNothing()
                        interactor.saveRates(viewParam: .init(rates: [:]))
                    }
                }
                
                it("should call saveRates in repository") {
                    verify(mockCurrencyConverterCoreData, times(1))
                        .saveRates(viewParam: any())
                }
            }
            
            context("interactor calls saveSymbols") {
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).saveSymbols(viewParam: any()).thenDoNothing()
                        interactor.saveSymbols(viewParam: .init(symbols: []))
                    }
                }
                
                it("should call saveSymbols in repository") {
                    verify(mockCurrencyConverterCoreData, times(1))
                        .saveSymbols(viewParam: any())
                }
            }
            
            context("interactor calls loadLastRatesRequest succeed") {
                var successData: Date!
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).loadLastRatesRequest()
                            .thenReturn(.just(Date(timeIntervalSince1970: 0)))
                        successData = try! interactor.loadLastRatesRequest().toBlocking().first()
                    }
                }
                
                it("should call loadLastRatesRequest in repository") {
                    verify(mockCurrencyConverterCoreData, times(1)).loadLastRatesRequest()
                }
                
                it("should get correct data") {
                    expect(successData).to(equal(Date(timeIntervalSince1970: 0)))
                }
            }
            
            context("interactor calls loadLastRatesRequest error") {
                let error = NSError(domain: "domain", code: 0)
                var errorData: NSError!
                
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).loadLastRatesRequest()
                            .thenReturn(.error(error))
                        do {
                            _  = try interactor.loadLastRatesRequest().toBlocking().first()
                        } catch let err as NSError {
                            errorData = err
                        }
                    }
                }
                
                it("should call loadLastRatesRequest in repository") {
                    verify(mockCurrencyConverterCoreData, times(1)).loadLastRatesRequest()
                }
                
                it("should get correct error") {
                    expect(errorData).to(equal(error))
                }
            }
            
            context("interactor calls loadLastSymbolsRequest succeed") {
                var successData: Date!
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).loadLastSymbolsRequest()
                            .thenReturn(.just(Date(timeIntervalSince1970: 0)))
                        successData = try! interactor.loadLastSymbolsRequest()
                            .toBlocking().first()
                    }
                }
                
                it("should call loadRates in repository") {
                    verify(mockCurrencyConverterCoreData, times(1)).loadLastSymbolsRequest()
                }
                
                it("should get correct data") {
                    expect(successData).to(equal(Date(timeIntervalSince1970: 0)))
                }
            }
            
            context("interactor calls loadLastSymbolsRequest error") {
                let error = NSError(domain: "domain", code: 0)
                var errorData: NSError!
                
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).loadLastSymbolsRequest()
                            .thenReturn(.error(error))
                        do {
                            _  = try interactor.loadLastSymbolsRequest().toBlocking().first()
                        } catch let err as NSError {
                            errorData = err
                        }
                    }
                }
                
                it("should call loadLastSymbolsRequest in repository") {
                    verify(mockCurrencyConverterCoreData, times(1)).loadLastSymbolsRequest()
                }
                
                it("should get correct error") {
                    expect(errorData).to(equal(error))
                }
            }
            
            context("interactor calls saveLastRatesRequest") {
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).saveLastRatesRequest(date: any()).thenDoNothing()
                        interactor.saveLastRatesRequest(date: Date())
                    }
                }
                
                it("should call saveLastRatesRequest in repository") {
                    verify(mockCurrencyConverterCoreData, times(1))
                        .saveLastRatesRequest(date: any())
                }
            }
            
            context("interactor calls saveLastSymbolsRequest") {
                beforeEach {
                    stub(mockCurrencyConverterCoreData) { stub in
                        when(stub).saveLastSymbolsRequest(date: any()).thenDoNothing()
                        interactor.saveLastSymbolsRequest(date: Date())
                    }
                }
                
                it("should call saveLastSymbolsRequest in repository") {
                    verify(mockCurrencyConverterCoreData, times(1))
                        .saveLastSymbolsRequest(date: any())
                }
            }
            
        }
        
    }
}
