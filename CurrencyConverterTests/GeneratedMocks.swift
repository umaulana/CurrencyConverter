import Cuckoo
@testable import CurrencyConverter

import Foundation
import RxSwift






 class MockCurrencyConverterCoreDataInteractor: CurrencyConverterCoreDataInteractor, Cuckoo.ProtocolMock {
    
     typealias MocksType = CurrencyConverterCoreDataInteractor
    
     typealias Stubbing = __StubbingProxy_CurrencyConverterCoreDataInteractor
     typealias Verification = __VerificationProxy_CurrencyConverterCoreDataInteractor

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CurrencyConverterCoreDataInteractor?

     func enableDefaultImplementation(_ stub: CurrencyConverterCoreDataInteractor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRatesViewParam> {
        
    return cuckoo_manager.call(
    """
    loadRates() -> Observable<CurrencyRatesViewParam>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadRates())
        
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbolsViewParam> {
        
    return cuckoo_manager.call(
    """
    loadSymbols() -> Observable<CurrencySymbolsViewParam>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadSymbols())
        
    }
    
    
    
    
    
     func saveRates(viewParam: CurrencyRatesViewParam)  {
        
    return cuckoo_manager.call(
    """
    saveRates(viewParam: CurrencyRatesViewParam)
    """,
            parameters: (viewParam),
            escapingParameters: (viewParam),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveRates(viewParam: viewParam))
        
    }
    
    
    
    
    
     func saveSymbols(viewParam: CurrencySymbolsViewParam)  {
        
    return cuckoo_manager.call(
    """
    saveSymbols(viewParam: CurrencySymbolsViewParam)
    """,
            parameters: (viewParam),
            escapingParameters: (viewParam),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveSymbols(viewParam: viewParam))
        
    }
    
    
    
    
    
     func loadLastRatesRequest() -> Observable<Date> {
        
    return cuckoo_manager.call(
    """
    loadLastRatesRequest() -> Observable<Date>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadLastRatesRequest())
        
    }
    
    
    
    
    
     func loadLastSymbolsRequest() -> Observable<Date> {
        
    return cuckoo_manager.call(
    """
    loadLastSymbolsRequest() -> Observable<Date>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadLastSymbolsRequest())
        
    }
    
    
    
    
    
     func saveLastRatesRequest(date: Date)  {
        
    return cuckoo_manager.call(
    """
    saveLastRatesRequest(date: Date)
    """,
            parameters: (date),
            escapingParameters: (date),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveLastRatesRequest(date: date))
        
    }
    
    
    
    
    
     func saveLastSymbolsRequest(date: Date)  {
        
    return cuckoo_manager.call(
    """
    saveLastSymbolsRequest(date: Date)
    """,
            parameters: (date),
            escapingParameters: (date),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveLastSymbolsRequest(date: date))
        
    }
    
    

     struct __StubbingProxy_CurrencyConverterCoreDataInteractor: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func loadRates() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencyRatesViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    loadRates() -> Observable<CurrencyRatesViewParam>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadSymbols() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencySymbolsViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    loadSymbols() -> Observable<CurrencySymbolsViewParam>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveRates<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CurrencyRatesViewParam)> where M1.MatchedType == CurrencyRatesViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencyRatesViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    saveRates(viewParam: CurrencyRatesViewParam)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveSymbols<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CurrencySymbolsViewParam)> where M1.MatchedType == CurrencySymbolsViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencySymbolsViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    saveSymbols(viewParam: CurrencySymbolsViewParam)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadLastRatesRequest() -> Cuckoo.ProtocolStubFunction<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    loadLastRatesRequest() -> Observable<Date>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadLastSymbolsRequest() -> Cuckoo.ProtocolStubFunction<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    loadLastSymbolsRequest() -> Observable<Date>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveLastRatesRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Date)> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    saveLastRatesRequest(date: Date)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveLastSymbolsRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Date)> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreDataInteractor.self, method:
    """
    saveLastSymbolsRequest(date: Date)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CurrencyConverterCoreDataInteractor: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func loadRates() -> Cuckoo.__DoNotUse<(), Observable<CurrencyRatesViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadRates() -> Observable<CurrencyRatesViewParam>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadSymbols() -> Cuckoo.__DoNotUse<(), Observable<CurrencySymbolsViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadSymbols() -> Observable<CurrencySymbolsViewParam>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveRates<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.__DoNotUse<(CurrencyRatesViewParam), Void> where M1.MatchedType == CurrencyRatesViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencyRatesViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return cuckoo_manager.verify(
    """
    saveRates(viewParam: CurrencyRatesViewParam)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveSymbols<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.__DoNotUse<(CurrencySymbolsViewParam), Void> where M1.MatchedType == CurrencySymbolsViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencySymbolsViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return cuckoo_manager.verify(
    """
    saveSymbols(viewParam: CurrencySymbolsViewParam)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadLastRatesRequest() -> Cuckoo.__DoNotUse<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadLastRatesRequest() -> Observable<Date>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadLastSymbolsRequest() -> Cuckoo.__DoNotUse<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadLastSymbolsRequest() -> Observable<Date>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveLastRatesRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.__DoNotUse<(Date), Void> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return cuckoo_manager.verify(
    """
    saveLastRatesRequest(date: Date)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveLastSymbolsRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.__DoNotUse<(Date), Void> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return cuckoo_manager.verify(
    """
    saveLastSymbolsRequest(date: Date)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CurrencyConverterCoreDataInteractorStub: CurrencyConverterCoreDataInteractor {
    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRatesViewParam>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencyRatesViewParam>).self)
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbolsViewParam>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencySymbolsViewParam>).self)
    }
    
    
    
    
    
     func saveRates(viewParam: CurrencyRatesViewParam)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func saveSymbols(viewParam: CurrencySymbolsViewParam)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func loadLastRatesRequest() -> Observable<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Date>).self)
    }
    
    
    
    
    
     func loadLastSymbolsRequest() -> Observable<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Date>).self)
    }
    
    
    
    
    
     func saveLastRatesRequest(date: Date)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func saveLastSymbolsRequest(date: Date)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





import Cuckoo
@testable import CurrencyConverter

import Foundation
import RxSwift






 class MockCurrencyConverterInteractor: CurrencyConverterInteractor, Cuckoo.ProtocolMock {
    
     typealias MocksType = CurrencyConverterInteractor
    
     typealias Stubbing = __StubbingProxy_CurrencyConverterInteractor
     typealias Verification = __VerificationProxy_CurrencyConverterInteractor

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CurrencyConverterInteractor?

     func enableDefaultImplementation(_ stub: CurrencyConverterInteractor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRatesViewParam> {
        
    return cuckoo_manager.call(
    """
    loadRates() -> Observable<CurrencyRatesViewParam>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadRates())
        
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbolsViewParam> {
        
    return cuckoo_manager.call(
    """
    loadSymbols() -> Observable<CurrencySymbolsViewParam>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadSymbols())
        
    }
    
    

     struct __StubbingProxy_CurrencyConverterInteractor: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func loadRates() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencyRatesViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterInteractor.self, method:
    """
    loadRates() -> Observable<CurrencyRatesViewParam>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadSymbols() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencySymbolsViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterInteractor.self, method:
    """
    loadSymbols() -> Observable<CurrencySymbolsViewParam>
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CurrencyConverterInteractor: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func loadRates() -> Cuckoo.__DoNotUse<(), Observable<CurrencyRatesViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadRates() -> Observable<CurrencyRatesViewParam>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadSymbols() -> Cuckoo.__DoNotUse<(), Observable<CurrencySymbolsViewParam>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadSymbols() -> Observable<CurrencySymbolsViewParam>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CurrencyConverterInteractorStub: CurrencyConverterInteractor {
    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRatesViewParam>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencyRatesViewParam>).self)
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbolsViewParam>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencySymbolsViewParam>).self)
    }
    
    
}





import Cuckoo
@testable import CurrencyConverter

import Foundation
import RxSwift






 class MockCurrencyConverterApi: CurrencyConverterApi, Cuckoo.ProtocolMock {
    
     typealias MocksType = CurrencyConverterApi
    
     typealias Stubbing = __StubbingProxy_CurrencyConverterApi
     typealias Verification = __VerificationProxy_CurrencyConverterApi

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CurrencyConverterApi?

     func enableDefaultImplementation(_ stub: CurrencyConverterApi) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRates> {
        
    return cuckoo_manager.call(
    """
    loadRates() -> Observable<CurrencyRates>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadRates())
        
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbols> {
        
    return cuckoo_manager.call(
    """
    loadSymbols() -> Observable<CurrencySymbols>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadSymbols())
        
    }
    
    

     struct __StubbingProxy_CurrencyConverterApi: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func loadRates() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencyRates>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterApi.self, method:
    """
    loadRates() -> Observable<CurrencyRates>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadSymbols() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencySymbols>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterApi.self, method:
    """
    loadSymbols() -> Observable<CurrencySymbols>
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CurrencyConverterApi: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func loadRates() -> Cuckoo.__DoNotUse<(), Observable<CurrencyRates>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadRates() -> Observable<CurrencyRates>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadSymbols() -> Cuckoo.__DoNotUse<(), Observable<CurrencySymbols>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadSymbols() -> Observable<CurrencySymbols>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CurrencyConverterApiStub: CurrencyConverterApi {
    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRates>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencyRates>).self)
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbols>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencySymbols>).self)
    }
    
    
}





import Cuckoo
@testable import CurrencyConverter

import Foundation
import RxSwift






 class MockCurrencyConverterCoreData: CurrencyConverterCoreData, Cuckoo.ProtocolMock {
    
     typealias MocksType = CurrencyConverterCoreData
    
     typealias Stubbing = __StubbingProxy_CurrencyConverterCoreData
     typealias Verification = __VerificationProxy_CurrencyConverterCoreData

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CurrencyConverterCoreData?

     func enableDefaultImplementation(_ stub: CurrencyConverterCoreData) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRates> {
        
    return cuckoo_manager.call(
    """
    loadRates() -> Observable<CurrencyRates>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadRates())
        
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbols> {
        
    return cuckoo_manager.call(
    """
    loadSymbols() -> Observable<CurrencySymbols>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadSymbols())
        
    }
    
    
    
    
    
     func saveRates(viewParam: CurrencyRatesViewParam)  {
        
    return cuckoo_manager.call(
    """
    saveRates(viewParam: CurrencyRatesViewParam)
    """,
            parameters: (viewParam),
            escapingParameters: (viewParam),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveRates(viewParam: viewParam))
        
    }
    
    
    
    
    
     func saveSymbols(viewParam: CurrencySymbolsViewParam)  {
        
    return cuckoo_manager.call(
    """
    saveSymbols(viewParam: CurrencySymbolsViewParam)
    """,
            parameters: (viewParam),
            escapingParameters: (viewParam),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveSymbols(viewParam: viewParam))
        
    }
    
    
    
    
    
     func loadLastRatesRequest() -> Observable<Date> {
        
    return cuckoo_manager.call(
    """
    loadLastRatesRequest() -> Observable<Date>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadLastRatesRequest())
        
    }
    
    
    
    
    
     func loadLastSymbolsRequest() -> Observable<Date> {
        
    return cuckoo_manager.call(
    """
    loadLastSymbolsRequest() -> Observable<Date>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadLastSymbolsRequest())
        
    }
    
    
    
    
    
     func saveLastRatesRequest(date: Date)  {
        
    return cuckoo_manager.call(
    """
    saveLastRatesRequest(date: Date)
    """,
            parameters: (date),
            escapingParameters: (date),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveLastRatesRequest(date: date))
        
    }
    
    
    
    
    
     func saveLastSymbolsRequest(date: Date)  {
        
    return cuckoo_manager.call(
    """
    saveLastSymbolsRequest(date: Date)
    """,
            parameters: (date),
            escapingParameters: (date),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveLastSymbolsRequest(date: date))
        
    }
    
    

     struct __StubbingProxy_CurrencyConverterCoreData: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func loadRates() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencyRates>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    loadRates() -> Observable<CurrencyRates>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadSymbols() -> Cuckoo.ProtocolStubFunction<(), Observable<CurrencySymbols>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    loadSymbols() -> Observable<CurrencySymbols>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveRates<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CurrencyRatesViewParam)> where M1.MatchedType == CurrencyRatesViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencyRatesViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    saveRates(viewParam: CurrencyRatesViewParam)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveSymbols<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CurrencySymbolsViewParam)> where M1.MatchedType == CurrencySymbolsViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencySymbolsViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    saveSymbols(viewParam: CurrencySymbolsViewParam)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadLastRatesRequest() -> Cuckoo.ProtocolStubFunction<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    loadLastRatesRequest() -> Observable<Date>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func loadLastSymbolsRequest() -> Cuckoo.ProtocolStubFunction<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    loadLastSymbolsRequest() -> Observable<Date>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveLastRatesRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Date)> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    saveLastRatesRequest(date: Date)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func saveLastSymbolsRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Date)> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCurrencyConverterCoreData.self, method:
    """
    saveLastSymbolsRequest(date: Date)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CurrencyConverterCoreData: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func loadRates() -> Cuckoo.__DoNotUse<(), Observable<CurrencyRates>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadRates() -> Observable<CurrencyRates>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadSymbols() -> Cuckoo.__DoNotUse<(), Observable<CurrencySymbols>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadSymbols() -> Observable<CurrencySymbols>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveRates<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.__DoNotUse<(CurrencyRatesViewParam), Void> where M1.MatchedType == CurrencyRatesViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencyRatesViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return cuckoo_manager.verify(
    """
    saveRates(viewParam: CurrencyRatesViewParam)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveSymbols<M1: Cuckoo.Matchable>(viewParam: M1) -> Cuckoo.__DoNotUse<(CurrencySymbolsViewParam), Void> where M1.MatchedType == CurrencySymbolsViewParam {
            let matchers: [Cuckoo.ParameterMatcher<(CurrencySymbolsViewParam)>] = [wrap(matchable: viewParam) { $0 }]
            return cuckoo_manager.verify(
    """
    saveSymbols(viewParam: CurrencySymbolsViewParam)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadLastRatesRequest() -> Cuckoo.__DoNotUse<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadLastRatesRequest() -> Observable<Date>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func loadLastSymbolsRequest() -> Cuckoo.__DoNotUse<(), Observable<Date>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    loadLastSymbolsRequest() -> Observable<Date>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveLastRatesRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.__DoNotUse<(Date), Void> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return cuckoo_manager.verify(
    """
    saveLastRatesRequest(date: Date)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func saveLastSymbolsRequest<M1: Cuckoo.Matchable>(date: M1) -> Cuckoo.__DoNotUse<(Date), Void> where M1.MatchedType == Date {
            let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
            return cuckoo_manager.verify(
    """
    saveLastSymbolsRequest(date: Date)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CurrencyConverterCoreDataStub: CurrencyConverterCoreData {
    

    

    
    
    
    
     func loadRates() -> Observable<CurrencyRates>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencyRates>).self)
    }
    
    
    
    
    
     func loadSymbols() -> Observable<CurrencySymbols>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CurrencySymbols>).self)
    }
    
    
    
    
    
     func saveRates(viewParam: CurrencyRatesViewParam)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func saveSymbols(viewParam: CurrencySymbolsViewParam)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func loadLastRatesRequest() -> Observable<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Date>).self)
    }
    
    
    
    
    
     func loadLastSymbolsRequest() -> Observable<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Date>).self)
    }
    
    
    
    
    
     func saveLastRatesRequest(date: Date)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func saveLastSymbolsRequest(date: Date)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}




