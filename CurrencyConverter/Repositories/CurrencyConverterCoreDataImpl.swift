//
//  CurrencyConverterCoreDataImpl.swift
//  CurrencyConverter
//
//  Created by umam on 28/01/23.
//

import CoreData
import Foundation
import RxSwift

class CurrencyConverterCoreDataImpl: CurrencyConverterCoreData {
    private let appDelegate: AppDelegate
    private let context: NSManagedObjectContext
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func loadRates() -> Observable<CurrencyRates> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<CurrencyRatesEntity> = CurrencyRatesEntity.fetchRequest()
            
            do {
                let currencyRatesEntities = try self.context.fetch(fetchRequest)
                var rates: [String: Double] = [:]
                
                for entity in currencyRatesEntities {
                    guard let symbol = entity.symbol else { continue }
                    rates[symbol] = entity.value
                }
                
                observer.on(.next(CurrencyRates(rates: rates)))
                observer.on(.completed)
            } catch {
                observer.on(.next(CurrencyRates(rates: [:])))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }
    }
    
    func loadSymbols() -> Observable<CurrencySymbols> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<CurrencySymbolsEntity> = CurrencySymbolsEntity.fetchRequest()
            
            do {
                let currencySymbolsEntities = try self.context.fetch(fetchRequest)
                var symbols: [String: String] = [:]
                
                for entity in currencySymbolsEntities {
                    guard let symbol = entity.symbol, let name = entity.name else { continue }
                    symbols[symbol] = name
                }
                
                observer.onNext(CurrencySymbols(symbols: symbols))
                observer.on(.completed)
            } catch {
                observer.onNext(CurrencySymbols(symbols: [:]))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }
    }
    
    func saveRates(viewParam: CurrencyRatesViewParam) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CurrencyRatesEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print(error)
            return
        }
        
        for rate in viewParam.rates {
            let rateContext = CurrencyRatesEntity(context: context)
            rateContext.symbol = rate.key
            rateContext.value = rate.value
        }
        
        appDelegate.saveContext()
    }
    
    func saveSymbols(viewParam: CurrencySymbolsViewParam) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CurrencySymbolsEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print(error)
            return
        }
        
        for symbol in viewParam.symbols {
            let symbolContext = CurrencySymbolsEntity(context: context)
            symbolContext.symbol = symbol.symbol
            symbolContext.name = symbol.name
        }
        
        appDelegate.saveContext()
    }
    
    func loadLastRatesRequest() -> Observable<Date> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<LastRatesRequestEntity> = LastRatesRequestEntity.fetchRequest()

            do {
                let lastRatesRequestEntity = try self.context.fetch(fetchRequest)
                
                guard let value = lastRatesRequestEntity.first?.value else {
                    throw NSError(domain: "failed to load last rates request", code: 0)
                }
                
                observer.on(.next(value))
                observer.on(.completed)
            } catch let error as NSError {
                observer.on(.error(error))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }
    }
    
    func loadLastSymbolsRequest() -> Observable<Date> {
        return Observable.create { observer in
            let fetchRequest: NSFetchRequest<LastSymbolsRequestEntity> = LastSymbolsRequestEntity.fetchRequest()

            do {
                let lastSymbolsRequestEntity = try self.context.fetch(fetchRequest)
                
                guard let value = lastSymbolsRequestEntity.first?.value else {
                    throw NSError(domain: "failed to load last symbols request", code: 0)
                }
                
                observer.on(.next(value))
                observer.on(.completed)
            } catch let error as NSError {
                observer.on(.error(error))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }
    }
    
    func saveLastRatesRequest(date: Date) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LastRatesRequestEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print(error)
            return
        }
        
        let context = LastRatesRequestEntity(context: context)
        context.value = date
        
        
        appDelegate.saveContext()
    }
    
    func saveLastSymbolsRequest(date: Date) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LastSymbolsRequestEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print(error)
            return
        }
        
        let context = LastSymbolsRequestEntity(context: context)
        context.value = date
        
        
        appDelegate.saveContext()
    }
}
