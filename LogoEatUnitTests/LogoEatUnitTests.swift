//
//  LogoEatUnitTests.swift
//  LogoEatUnitTests
//
//  Created by dsadas asdasd on 02.06.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import XCTest
@testable import LogoEat

class LogoEatUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingupWithExistingEmail() throws {
        let expectation = expectation(description: "Try to sing up")
        AuthorizationNetworkService.signup(name: "Name", phoneNumber: "+380673113311", email: "o.romanishina@gmail.com", password: "Nazar2020") { (dict) in
            guard let message = dict["message"] as? String else {return}
            XCTAssertEqual(message, "Email is already Occupied.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testChangeName() throws {
        let expectation = expectation(description: "Changed name")
        SettingsNetworkService.makeChangeRequest(parameters: ["name": "Olichka"], requestUrl: "update_name") { (dict) in
            guard let message = dict["message"] as? String else {return}
            XCTAssertEqual(message, "Name was changed.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

}
