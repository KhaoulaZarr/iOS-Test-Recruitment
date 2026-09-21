//
//  CategoriesFilterUITests.swift
//  TheGoodCornerUITests
//
//  Created by Khawla Zarrami on 21/09/2026.
//

import XCTest

final class CategoriesFilterUITests: XCTestCase {

    private var app: XCUIApplication!

        override func setUp() {
            continueAfterFailure = false

            app = XCUIApplication()
            app.launchArguments = ["-ui-testing"]
            app.launchEnvironment = ["-networking-success": "1"]
            app.launch()
        }

        override func tearDown() {
            app = nil
        }
    
    // When the user taps the filter button, does the category filter screen appear?
    func test_filter_screen_is_displayed_when_filter_button_is_tapped() {
        let filterButton = app.buttons["Filter listings"]
        XCTAssertTrue(filterButton.waitForExistence(timeout: 5), "The filter button should be visible")
        filterButton.tap()
        let filterScreen = app.navigationBars["Filters"]
        XCTAssertTrue(
            filterScreen.waitForExistence(timeout: 5),
            "The category filter screen should be visible"
        )
    }
    
    
    // When the user selects category, are the listings filtered correctly?
    func test_select_category_filters_listings() {
        let categoryId = 7

        let filterButton = app.buttons["Filter listings"]

        XCTAssertTrue(
            filterButton.waitForExistence(timeout: 5),
            "The filter button should be visible"
        )

        filterButton.tap()

        let categoryButton = app.buttons["category_\(categoryId)"]

        XCTAssertTrue(
            categoryButton.waitForExistence(timeout: 5),
            "Category 7 should be visible"
        )

        categoryButton.tap()

        let applyButton = app.buttons["applyFilterButton"]

        XCTAssertTrue(
            applyButton.waitForExistence(timeout: 5),
            "The Apply button should be visible"
        )

        applyButton.tap()

        let list = app.otherElements["listingList"]

        XCTAssertTrue(
            list.waitForExistence(timeout: 5),
            "The listing list should be visible"
        )

        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = list.buttons.containing(predicate)
        
        XCTAssertEqual(listItems.count, 3, "There should be 3 items on the screen")
        
        // First listing
        XCTAssertTrue(listItems.staticTexts["Vinyle Elliott Murphy Just A Story From America"].exists)
        XCTAssertTrue(listItems.staticTexts["10,00 €"].exists)
        XCTAssertTrue(listItems.staticTexts["LIVRES/CD/DVD"].exists)

        // Second listing
        XCTAssertTrue(listItems.staticTexts["Vinyle Lalo Schifrin Mission: Impossible"].exists)
        XCTAssertTrue(listItems.staticTexts["10,00 €"].exists)
        XCTAssertTrue(listItems.staticTexts["LIVRES/CD/DVD"].exists)
        
        // Third listing
        XCTAssertTrue(listItems.staticTexts["Les morts du Karst de Veit Heinichen"].exists)
        XCTAssertTrue(listItems.staticTexts["3,00 €"].exists)
        XCTAssertTrue(listItems.staticTexts["LIVRES/CD/DVD"].exists)
    }
}
