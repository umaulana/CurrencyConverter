//
//  CurrencyConverterApiImpl.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import Alamofire
import Foundation
import RxSwift

class CurrencyConverterApiImpl: CurrencyConverterApi {
    private let appId = "66330d36c07b4dc2960f25ee7dd943b2"
    private let baseUrl = "https://openexchangerates.org/api/"
    
    func loadRates() -> Observable<CurrencyRates> {
        let urlString = baseUrl + "latest.json"
        let params = ["app_id": appId]
        
        return Observable.create { observer in
            let request = AF.request(urlString, method: .get, parameters: params, encoding: URLEncoding.queryString)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(_):
                        do {
                            let ratesResponse = try JSONDecoder().decode(CurrencyRatesResponse.self, from: response.data!)
                            observer.on(.next(ratesResponse.toCurrencyRates()))
                            observer.on(.completed)
                        } catch let error as NSError {
                            observer.on(.error(error))
                            return
                        }
                    case .failure(let error):
                        observer.on(.error(error))
                        return
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func loadSymbols() -> Observable<CurrencySymbols> {
        let urlString = baseUrl + "currencies.json"
        let params = ["app_id": appId]
        
        return Observable.create { observer in
            let request = AF.request(urlString, method: .get, parameters: params, encoding: URLEncoding.queryString)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(_):
                        do {
                            let symbolsResponse = try JSONDecoder().decode([String: String]?.self, from: response.data!)
                            observer.on(.next(CurrencySymbols(symbols: symbolsResponse ?? [:])))
                            observer.on(.completed)
                        } catch let error as NSError {
                            observer.on(.error(error))
                            return
                        }
                    case .failure(let error):
                        observer.on(.error(error))
                        return
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
