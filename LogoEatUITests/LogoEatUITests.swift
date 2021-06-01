//
//  LogoEatUITests.swift
//  LogoEatUITests
//
//  Created by dsadas asdasd on 31.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import XCTest

class LogoEatUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChangePhoneNumberValidation() throws {
        
        let invalidPhoneNumber = "012345678"
        
        
        let app = XCUIApplication()
        app.launch()
        let tabBar = XCUIApplication().tabBars
        tabBar.buttons["Settings"].tap()
        app.buttons["change-phone"].tap()
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText(invalidPhoneNumber)
        textField.typeText("\n")
        app.buttons["confirm"].tap()
        let phoneError = app.staticTexts["change-error"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: phoneError, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDetailScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables.firstMatch
        let tableCell = tableView.cells.firstMatch
        let check = tableCell.staticTexts["booking-name"].value
        tableCell.tap()
        let restaurantName = app.staticTexts["detail-name"].value
        XCTAssertEqual(restaurantName as! String, check as! String)
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
}
