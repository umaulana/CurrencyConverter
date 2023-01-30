//
//  String+ExtensionsTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 28/01/23.
//

import Nimble
import Quick
import XCTest

final class String_ExtensionsTests: QuickSpec {
    override func spec() {
        describe("add zero if necessary") {
            
            context("user type .01") {
                it("should show 0.01") {
                    expect(".01".addZeroIfNecessary).to(equal("0.01"))
                }
            }
            
            context("user type 30.") {
                it("should show 30.0") {
                    expect("30.".addZeroIfNecessary).to(equal("30.0"))
                }
            }
            
            context("user type .") {
                it("should show 0.0") {
                    expect(".".addZeroIfNecessary).to(equal("0.0"))
                }
            }
            
        }
    }
}
