//
//  ListingsScreenUITests.swift
//  TheGoodCornerUITests
//
//  Created by Khawla Zarrami on 19/09/2026.
//

import XCTest

final class ListingsScreenUITests: XCTestCase {
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
    
    // When the screen loads successfully, does the listings view display the correct number of listings and their expected content?
    func test_list_has_correct_number_of_items_when_screen_loads() {
        let list = app.otherElements["listingList"]
        XCTAssertTrue(list.waitForExistence(timeout: 5), "The Listing list should be visible")
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = list.buttons.containing(predicate)
        XCTAssertEqual(listItems.count, 5, "There should be 5 items on the screen")
        // First listing
            XCTAssertTrue(listItems.staticTexts["Vinyle Elliott Murphy Just A Story From America"].exists)
            XCTAssertTrue(listItems.staticTexts["10,00 €"].exists)
            XCTAssertTrue(listItems.staticTexts["LIVRES/CD/DVD"].exists)

            // Second listing
            XCTAssertTrue(listItems.staticTexts["Poussette Bugaboo Bee"].exists)
            XCTAssertTrue(listItems.staticTexts["250,00 €"].exists)
            XCTAssertTrue(listItems.staticTexts["ENFANTS"].exists)

            // Third listing
            XCTAssertTrue(listItems.staticTexts["Vinyle Lalo Schifrin Mission: Impossible"].exists)
            XCTAssertTrue(listItems.staticTexts["10,00 €"].exists)
            XCTAssertTrue(listItems.staticTexts["LIVRES/CD/DVD"].exists)

            // Fourth listing
            XCTAssertTrue(listItems.staticTexts["Brosse à dent électrique 2 en 1 NEUVE Hybrid"].exists)
            XCTAssertTrue(listItems.staticTexts["25,00 €"].exists)
            XCTAssertTrue(listItems.staticTexts["MAISON"].exists)

            // Fifth listing
            XCTAssertTrue(listItems.staticTexts["Les morts du Karst de Veit Heinichen"].exists)
            XCTAssertTrue(listItems.staticTexts["3,00 €"].exists)
            XCTAssertTrue(listItems.staticTexts["LIVRES/CD/DVD"].exists)
    }
}
