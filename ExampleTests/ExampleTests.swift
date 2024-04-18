//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Sachin Nautiyal on 15/05/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import XCTest

class ExampleTests: XCTestCase {
    
    var app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitesting"]
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.buttons["Pay Now"].tap()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
