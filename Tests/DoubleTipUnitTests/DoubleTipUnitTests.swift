//
//  DoubleTipUnitTests.swift
//  DoubleTipUnitTests
//
//  Created by Jake Sulkoske on 8/8/24.
//

@testable import DoubleTip
import XCTest

final class DoubleTipUnitTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testCurrencyFormatterTwoDecimals() {
        let expectedStringValue: String = "$120.00"
        let amountAsDouble: Double = 120.00
        XCTAssertEqual(amountAsDouble.formattedAsCurrency(), expectedStringValue)
    }
    
    func testCurrencyFormatterNoDecimals() {
        let expectedStringValue: String = "$120"
        let amountAsDouble: Double = 120.00
        XCTAssertEqual(amountAsDouble.formattedAsCurrency(maxDecimalPoint: 0), expectedStringValue)
    }
    
    func testTotalAmountWithTipAsDouble() {
        let expenseValue: Double = 100.00
        let tipPercentageValue: Int = 20
        let expectedOutput: Double = 120.00
        let amount = GlobalUtilities.totalAmountWiithTipAsDouble(totalExpense: expenseValue, tipPercentage: tipPercentageValue)
        XCTAssertEqual(amount, expectedOutput)
    }
    
    func testTotalAmountWithTipReturnsNilWithZeroValue() {
        let expenseValue: Double = 100.00
        let tipPercentageValue: Int = 0
        let amount = GlobalUtilities.totalAmountWiithTipAsDouble(totalExpense: expenseValue, tipPercentage: tipPercentageValue)
        XCTAssertEqual(amount, nil)
    }
}
