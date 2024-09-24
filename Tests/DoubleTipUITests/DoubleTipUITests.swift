//
//  DoubleTipUITests.swift
//  DoubleTipUITests
//
//  Created by Jake Sulkoske on 8/8/24.
//

import XCTest

final class DoubleTipUITests: XCTestCase {
    
    private let kBillAmount: String = "BILL AMOUNT"
    private let kZeroBillText: String = "$0.00"
    private let k15PercentText: String = "15%"
    private let kCalculate: String = "Calculate"
    private let kTipPercentage: String = "TIP PERCENTAGE"
    private let kTotal: String = "TOTAL"
    private let k120DollarTotal: String = "$120.00"
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app = nil
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testRequiredFieldsShowsOnLaunch() {
        let collectionViewsQuery = app.collectionViews
        
        XCTAssert(collectionViewsQuery.staticTexts[kBillAmount].exists, "Bill amount section title is not showing on launch")
        XCTAssert(collectionViewsQuery.textFields[kZeroBillText].exists, "Bill amount text field is not showing on launch")
        
        XCTAssert(collectionViewsQuery.staticTexts[kTipPercentage].exists, "Tip percentage section title is not showing on launch")
        XCTAssert(collectionViewsQuery.textFields[k15PercentText].exists, "Tip percentage text field is not showing on launch")
        
        XCTAssert(collectionViewsQuery.buttons[kCalculate].exists, "Calculate button is not showing on launch")
        
        XCTAssertFalse(collectionViewsQuery.staticTexts[kTotal].exists, "Total section title is showing on launch")
    }
    
    func testCalculateButtonActionHappyPath() {
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery.textFields[kZeroBillText].tap()
        collectionViewsQuery.textFields[kZeroBillText].typeText("$100.00")
        
        collectionViewsQuery.textFields[k15PercentText].tap()
        collectionViewsQuery.textFields[k15PercentText].typeText("20%")
        
        dismissKeyboardIfPresent()
        
        collectionViewsQuery.buttons[kCalculate].tap()
        
        XCTAssert(collectionViewsQuery.staticTexts[kTotal].exists, "Total section title not showing when case satisfies")
        XCTAssert(collectionViewsQuery.staticTexts[k120DollarTotal].exists, "Total text field not showing when case satisfies")
    }
    
    func testCalculateButtonActionEmptyTipPercentage() {
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery.textFields[kZeroBillText].tap()
        collectionViewsQuery.textFields[kZeroBillText].typeText("$100.00")
        
        dismissKeyboardIfPresent()
        
        collectionViewsQuery.buttons[kCalculate].tap()
        
        XCTAssertFalse(collectionViewsQuery.staticTexts[kTotal].exists, "Total section title showing when tip percent empty")
        XCTAssertFalse(collectionViewsQuery.staticTexts[k120DollarTotal].exists, "Total text field showing when tip percent empty")
    }
}

extension DoubleTipUITests {
    private func dismissKeyboardIfPresent() {
        if app.keyboards.element(boundBy: 0).exists {
            app.keyboards.buttons["return"].tap()
        }
    }
}
