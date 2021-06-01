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

    func testSignupValidation() throws {
        
        let invalidEmail = "invalid@@mail.ru"
        
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Sign up"].tap()
        let emailTextField = app.textFields["e-mail"]
        emailTextField.tap()
        emailTextField.typeText(invalidEmail)
        emailTextField.typeText("\n")
        app.buttons["sign-up"].tap()
        let emailError = app.staticTexts["e-mail error"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: emailError, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDetailScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
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
