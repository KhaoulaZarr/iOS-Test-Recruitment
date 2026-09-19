//
//  ListingsFailureUITests.swift
//  TheGoodCornerUITests
//
//  Created by Khawla Zarrami on 19/09/2026.
//

import XCTest

final class ListingsFailureUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success": "0"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    // When the server returns an invalid response, does the error message and Retry button display?
    func test_error_message_is_shown_when_screen_fails_to_load() {
        let errorMessage = app.staticTexts["The server returned an invalid response."]
        let retryButton = app.buttons["Retry"]

        XCTAssertTrue(
            errorMessage.waitForExistence(timeout: 3),
            "The error message should be visible on the screen"
        )

        XCTAssertTrue(
        retryButton.exists,
        "The Retry button should be visible on the screen"
        )
    }
}
