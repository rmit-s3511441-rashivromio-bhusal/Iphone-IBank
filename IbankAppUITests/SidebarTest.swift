//
//  SidebarTest.swift
//  IbankApp
//
//  Created by Naveen Bajaj on 10/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import XCTest

class SidebarTest: XCTestCase {
    
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

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        app.navigationBars["IbankApp.SigninSettingCtrl"].buttons["HoMHP"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Features"].tap()
        app.navigationBars["Features"].buttons["HoMHP"].tap()
        tablesQuery.staticTexts["Security"].tap()
        app.navigationBars["Security"].buttons["HoMHP"].tap()
        tablesQuery.staticTexts["Policy"].tap()
        app.navigationBars["Policies"].buttons["HoMHP"].tap()
        tablesQuery.staticTexts["Contact Us"].tap()
        app.navigationBars["Contact Us"].buttons["HoMHP"].tap()
        tablesQuery.staticTexts["SignIn"].tap()
        
    }

}
