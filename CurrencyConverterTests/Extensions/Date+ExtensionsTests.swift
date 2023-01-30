//
//  Date+ExtensionsTests.swift
//  CurrencyConverterTests
//
//  Created by umam on 28/01/23.
//

import Nimble
import Quick
import XCTest

final class Date_ExtensionsTests: QuickSpec {
    override func spec() {
        describe("date is different by exactly 30 minutes to other date") {
            
            context("dates are different by 30 minutes") {
                it("should return true") {
                    let thirtyMinutes: Double = 30 * 60
                    let firstDate = Date(timeIntervalSince1970: 0)
                    let secondDate = Date(timeIntervalSince1970: 0).addingTimeInterval(thirtyMinutes)
                    
                    expect(firstDate.is30MinutesDifferent(from: secondDate)).to(beTrue())
                }
            }
            
            context("dates are different by less than 30 minutes") {
                it("should return false") {
                    let twentyMinutes: Double = 20 * 60
                    let firstDate = Date(timeIntervalSince1970: 0)
                    let secondDate = Date(timeIntervalSince1970: 0).addingTimeInterval(twentyMinutes)
                    
                    expect(firstDate.is30MinutesDifferent(from: secondDate)).to(beFalse())
                }
            }
            
            context("dates are different by more than 30 minutes") {
                it("should return true") {
                    let fourtyMinutes: Double = 40 * 60
                    let firstDate = Date(timeIntervalSince1970: 0)
                    let secondDate = Date(timeIntervalSince1970: 0).addingTimeInterval(fourtyMinutes)
                    
                    expect(firstDate.is30MinutesDifferent(from: secondDate)).to(beTrue())
                }
            }
            
        }
    }
}
