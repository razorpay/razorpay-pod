//
//  ExampleUITests.swift
//  ExampleUITests
//
//  Created by Manukant Harshmani Tyagi on 10/12/25.
//  Copyright © 2025 Razorpay. All rights reserved.
//

import XCTest

final class ExampleUITests: XCTestCase {

    @MainActor
    func testUpiSuccessFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        
        checkWebViewExistence(app: app)
        
        let upiSection = app.staticTexts["UPI"].firstMatch
        XCTAssertTrue(upiSection.waitForExistence(timeout: 10), "UPI section not found")
        upiSection.tap()
        
        let textfield = app.textFields["example@okhdfcbank"]
        XCTAssertTrue(textfield.waitForExistence(timeout: 10))
        textfield.tap()
        textfield.typeText("success@razorpay")
        app.keyboards.buttons["return"].tap()
        
        successAlertExists(app: app)
    
    }
    
    @MainActor
    func testUpiFailureFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        
        checkWebViewExistence(app: app)
        
        let upiSection = app.staticTexts["UPI"].firstMatch
        XCTAssertTrue(upiSection.waitForExistence(timeout: 10), "UPI section not found")
        upiSection.tap()
        
        let textfield = app.textFields["example@okhdfcbank"].firstMatch
        XCTAssertTrue(textfield.waitForExistence(timeout: 10))
        textfield.tap()
        
        Thread.sleep(forTimeInterval: 1)
        textfield.typeText("failure@razorpay")
        app.keyboards.buttons["return"].tap()
        
        let failureAlert = app.staticTexts["Payment could not be completed"].firstMatch
        XCTAssertTrue(failureAlert.waitForExistence(timeout: 10), "FAILURE alert did not appear")
    
    }
    
    @MainActor
    func testCardPaymentSuccessFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        checkWebViewExistence(app: app)
        
        let webview = app.webViews["razorpay_webview"].firstMatch
        XCTAssertTrue(webview.waitForExistence(timeout: 10), "webview does not exist")
        XCTAssertTrue(webview.isHittable, "webview is not hittable")
        
        let cardsSection = app.staticTexts["Cards"].firstMatch
        XCTAssertTrue(cardsSection.waitForExistence(timeout: 10), "Cards section not found")
        cardsSection.tap()
        
        let cardNumberTextfield = app.textFields["Card Number"]
        XCTAssertTrue(cardNumberTextfield.waitForExistence(timeout: 10), "Card Number textfield not found")
        cardNumberTextfield.tap()
        
        cardNumberTextfield.typeText("2305324257848228")
        
        let dateTextField = app.textFields["MM / YY"].firstMatch
        XCTAssertTrue(dateTextField.waitForExistence(timeout: 10), "Expiry Date does not exist")
        dateTextField.tap()
        dateTextField.typeText("12/29")
        
        let cvvTextField = app.textFields["CVV"].firstMatch
        XCTAssertTrue(cvvTextField.waitForExistence(timeout: 10), "CVV does not exist")
        cvvTextField.tap()
        cvvTextField.typeText("123")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        tapContinueButton(webView: webview)
        tapMaybeLaterButtonIfExist(webView: webview)
        tapSuccessButton(webView: webview)
        successAlertExists(app: app)
        
    }
    
    @MainActor
    func testCardPaymentFailureFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        let webview = checkWebViewExistence(app: app)
        
        let cardsSection = app.staticTexts["Cards"].firstMatch
        XCTAssertTrue(cardsSection.waitForExistence(timeout: 10), "Cards section not found")
        cardsSection.tap()
        
        let cardNumberTextfield = app.textFields["Card Number"]
        XCTAssertTrue(cardNumberTextfield.waitForExistence(timeout: 10), "Card Number textfield not found")
        cardNumberTextfield.tap()
        
        cardNumberTextfield.typeText("2305324257848228")
        
        let dateTextField = app.textFields["MM / YY"].firstMatch
        XCTAssertTrue(dateTextField.waitForExistence(timeout: 10), "Expiry Date does not exist")
        dateTextField.tap()
        dateTextField.typeText("12/29")
        
        let cvvTextField = app.textFields["CVV"].firstMatch
        XCTAssertTrue(cvvTextField.waitForExistence(timeout: 10), "CVV does not exist")
        cvvTextField.tap()
        cvvTextField.typeText("123")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        tapContinueButton(webView: webview)
        tapMaybeLaterButtonIfExist(webView: webview)
        tapFailureButton(webView: webview)
        failureAlertExists(app: app)
        
    }
    
    @MainActor
    func testNetbankingSuccessFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        
        let webview = checkWebViewExistence(app: app)
        
        let netBankingSection = app.otherElements["Netbanking"].firstMatch
        XCTAssertTrue(netBankingSection.waitForExistence(timeout: 10), "Cards section not found")
        netBankingSection.tap()
        
        let sbiButton = app.buttons["SBI SBI"].firstMatch
        XCTAssertTrue(sbiButton.waitForExistence(timeout: 10), "SBI button not found")
        sbiButton.tap()
        
        tapSuccessButton(webView: webview)
        successAlertExists(app: app)
        
    }
    
    @MainActor
    func testNetbankingFailureFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        
        let webview = checkWebViewExistence(app: app)
        
        let netBankingSection = app.otherElements["Netbanking"].firstMatch
        XCTAssertTrue(netBankingSection.waitForExistence(timeout: 10), "Cards section not found")
        netBankingSection.tap()
        
        let sbiButton = app.buttons["SBI SBI"].firstMatch
        XCTAssertTrue(sbiButton.waitForExistence(timeout: 10), "SBI button not found")
        sbiButton.tap()
        
        tapFailureButton(webView: webview)
        failureAlertExists(app: app)
        
    }
    
    @MainActor
    func testOlaWalletSuccesFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        
        let webview = checkWebViewExistence(app: app)
        
        let wallet = app.staticTexts["Wallet"].firstMatch
        XCTAssertTrue(wallet.waitForExistence(timeout: 10), "Wallet section not found")
        wallet.tap()
        
        let olaMoneyButton = app.otherElements["Ola Money (Postpaid + Wallet)"].firstMatch
        XCTAssertTrue(olaMoneyButton.waitForExistence(timeout: 10), "Ola Money button not found")
        olaMoneyButton.tap()
        
        tapSuccessButton(webView: webview)
        successAlertExists(app: app)
    }
    
    @MainActor
    func testOlaWalletFailureFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        tapOnPayNow(app: app)
        
        let webview = checkWebViewExistence(app: app)
        
        let wallet = app.staticTexts["Wallet"].firstMatch
        XCTAssertTrue(wallet.waitForExistence(timeout: 10), "Wallet section not found")
        wallet.tap()
        
        let olaMoneyButton = app.otherElements["Ola Money (Postpaid + Wallet)"].firstMatch
        XCTAssertTrue(olaMoneyButton.waitForExistence(timeout: 10), "Ola Money button not found")
        olaMoneyButton.tap()
        
        tapFailureButton(webView: webview)
        failureAlertExists(app: app)
    }
    
    
    
    //MARK: - Helper functions
    
    func tapOnPayNow(app: XCUIApplication)  {
        let element = app/*@START_MENU_TOKEN@*/.staticTexts["Pay Now"]/*[[".buttons",".staticTexts",".staticTexts[\"Pay Now\"]"],[[[-1,2],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        XCTAssertTrue(element.waitForExistence(timeout: 10))
        element.tap()
    }
    
    func successAlertExists(app: XCUIApplication) {
        let successAlert = app.alerts["Payment Successful"]
        XCTAssertTrue(successAlert.waitForExistence(timeout: 20), "SUCCESS alert did not appear")

        // If you just want to check that it mentions a payment id:
        let msgPredicate = NSPredicate(format: "label CONTAINS %@", "razorpay_payment_id")
        let messageLabel = successAlert.staticTexts.element(matching: msgPredicate)
        XCTAssertTrue(messageLabel.exists, "Alert message does not contain 'Payment Id'")
    }
    
    func failureAlertExists(app: XCUIApplication) {
        let failureAlert = app.alerts["Payment Failed"]
        XCTAssertTrue(failureAlert.waitForExistence(timeout: 10), "FAILURE alert did not appear")
    }    
    
    func tapSuccessButton(webView: XCUIElement) {
        let successButton = webView.buttons
            .containing(NSPredicate(format: "label CONTAINS[c] %@", "Success"))
            .firstMatch
        XCTAssertTrue(successButton.waitForExistence(timeout: 30),
                    "Success button did not appear in time")
        successButton.tap()
    }

    func tapFailureButton(webView: XCUIElement) {
        let failureButton = webView.buttons
            .containing(NSPredicate(format: "label CONTAINS[c] %@", "Failure"))
            .firstMatch
        XCTAssertTrue(failureButton.waitForExistence(timeout: 30),
                    "Failure button did not appear in time")
        failureButton.tap()
    }
       
    func tapContinueButton(webView: XCUIElement) {
        let continueButton = webView.buttons
            .containing(NSPredicate(format: "label CONTAINS[c] %@", "Continue"))
            .firstMatch
        
        XCTAssert(continueButton.waitForExistence(timeout: 5), "Continue button not found.")
        continueButton.tap()
    }
    
    @discardableResult
    func checkWebViewExistence(app: XCUIApplication) -> XCUIElement {
        let webview = app.webViews["razorpay_webview"].firstMatch
        XCTAssertTrue(webview.waitForExistence(timeout: 10), "webview does not exist")
        XCTAssertTrue(webview.isHittable, "webview is not hittable")
        return webview
    }
    
    func tapMaybeLaterButtonIfExist(webView: XCUIElement) {
        let mayBeLaterButton = webView.buttons
            .containing(NSPredicate(format: "label CONTAINS[c] %@", "Maybe later"))
            .firstMatch
        if mayBeLaterButton.exists {
            mayBeLaterButton.tap()
        }
    }
}
