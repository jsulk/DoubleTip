//
//  DoubleTipUITests.swift
//  DoubleTipUITests
//
//  Created by Jake Sulkoske on 8/8/24.
//

import XCTest

final class DoubleTipUITests: XCTestCase {
    
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
        
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["BILL AMOUNT"]/*[[".cells.staticTexts[\"BILL AMOUNT\"]",".staticTexts[\"BILL AMOUNT\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Bill amount section title is not showing on launch")
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells.textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Bill amount text field is not showing on launch")
        
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["TIP PERCENTAGE"]/*[[".cells.staticTexts[\"TIP PERCENTAGE\"]",".staticTexts[\"TIP PERCENTAGE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Tip percentage section title is not showing on launch")
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["15%"]/*[[".cells.textFields[\"15%\"]",".textFields[\"15%\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Tip percentage text field is not showing on launch")
        
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Calculate"]/*[[".cells.buttons[\"Calculate\"]",".buttons[\"Calculate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Calculate button is not showing on launch")
        
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["TOTAL"]/*[[".cells.staticTexts[\"TOTAL\"]",".staticTexts[\"TOTAL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Total section title is showing on launch")
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["$120.00"]/*[[".cells.staticTexts[\"$120.00\"]",".staticTexts[\"$120.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Total text field is showing on launch")
    }
    
    func testCalculateButtonActionHappyPath() {
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells.textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells.textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("$100.00")
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["15%"]/*[[".cells.textFields[\"15%\"]",".textFields[\"15%\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["15%"]/*[[".cells.textFields[\"15%\"]",".textFields[\"15%\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("20%")
        
        dismissKeyboardIfPresent()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Calculate"]/*[[".cells.buttons[\"Calculate\"]",".buttons[\"Calculate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["TOTAL"]/*[[".cells.staticTexts[\"TOTAL\"]",".staticTexts[\"TOTAL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Total section title not showing when case satisfies")
        XCTAssert(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["$120.00"]/*[[".cells.staticTexts[\"$120.00\"]",".staticTexts[\"$120.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Total text field not showing when case satisfies")
    }
    
    func testCalculateButtonActionEmptyTipPercentage() {
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells.textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells.textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("$100.00")
        
        dismissKeyboardIfPresent()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Calculate"]/*[[".cells.buttons[\"Calculate\"]",".buttons[\"Calculate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["TOTAL"]/*[[".cells.staticTexts[\"TOTAL\"]",".staticTexts[\"TOTAL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Total section title showing when tip percent empty")
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["$120.00"]/*[[".cells.staticTexts[\"$120.00\"]",".staticTexts[\"$120.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists, "Total text field showing when tip percent empty")
    }
}

extension DoubleTipUITests {
    private func dismissKeyboardIfPresent() {
        if app.keyboards.element(boundBy: 0).exists {
            app.keyboards.buttons["return"].tap()
        }
    }
}
