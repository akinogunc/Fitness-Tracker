//
//  TestCreateExercise.swift
//  Fitness TrackerUITests
//
//  Created by Maruf Nebil Ogunc on 17.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import XCTest

class TestCreateExercise: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateExercise() {
        
        let app = XCUIApplication()
        app.buttons["Create Workout"].tap()
        app.navigationBars["Create Workout"].buttons["Add"].tap()
        app.textFields["Exercise Name"].tap()
        app.textFields["Exercise Name"].typeText("Test Exercise")
        app.textFields["Exercise Name"].typeText("\n")

        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let upButton = element.children(matching: .button).matching(identifier: "up").element(boundBy: 0)
        upButton.tap()
        upButton.tap()
        upButton.tap()
        
        XCTAssertTrue(app.staticTexts["3 Sets"].exists)

        let upButton2 = element.children(matching: .button).matching(identifier: "up").element(boundBy: 1)
        upButton2.tap()
        upButton2.tap()
        upButton2.tap()
        upButton2.tap()
        
        XCTAssertTrue(app.staticTexts["4 Reps"].exists)

        let upButton3 = element.children(matching: .button).matching(identifier: "up").element(boundBy: 2)
        upButton3.tap()
        upButton3.tap()
        upButton3.tap()
        
        XCTAssertTrue(app.staticTexts["60 Seconds Rest"].exists)

        app.navigationBars["Create Exercise"].buttons["Add"].tap()
        
        XCTAssertTrue(app.staticTexts["Test Exercise"].exists)
        XCTAssertTrue(app.staticTexts["3"].exists)
        XCTAssertTrue(app.staticTexts["4"].exists)
        XCTAssertTrue(app.staticTexts["60s"].exists)

    }
    
}
