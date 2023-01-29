//
//  CurrencyConverterCoreDataImpl.swift
//  CurrencyConverter
//
//  Created by umam on 28/01/23.
//

import CoreData
import Foundation
import RxSwift

class CurrencyConverterCoreDataImpl {
    
    // MARK: - Core Data stack

    lazy var context: NSManagedObjectContext = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CurrencyConverterCoreDataImpl: CurrencyConverterCoreData {
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
        
        saveContext()
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
        
        saveContext()
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
        
        saveContext()
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
        
        saveContext()
    }
}
