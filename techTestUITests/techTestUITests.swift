//
//  techTestUITests.swift
//  techTestUITests
//
//  Created by David Stothers on 25/05/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import XCTest

class techTestUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        
        // We send a command line argument to our app, to enable it to reset its state
        app.launchArguments.append("--uitesting")

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
    }

    func testLaunchDisplaysCorrectly() {
        //This test ensures its loaded correctly
        app.launch()
        sleep(5)
        XCTAssertTrue(app.isDisplayingCorrectMainView)
    }
    
}
