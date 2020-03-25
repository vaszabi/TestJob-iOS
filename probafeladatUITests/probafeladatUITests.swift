//
//  probafeladatUITests.swift
//  probafeladatUITests
//
//  Created by Szabolcs Varga on 2019. 11. 25..
//  Copyright © 2019. WUP. All rights reserved.
//

import XCTest

class probafeladatUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSwipingCards() {
        
        let element = XCUIApplication().scrollViews.otherElements.containing(.button, identifier:"DETAILS").children(matching: .other).element(boundBy: 0)
        element.swipeRight()
        element.swipeLeft()
        element.swipeLeft()
        element.swipeLeft()
        element.swipeRight()
        
    }
    
    func testTappingButtons() {
        
        let element = XCUIApplication().scrollViews.otherElements.containing(.button, identifier:"DETAILS").children(matching: .other).element(boundBy: 0)
        let icArrowleftButton = element.children(matching: .button).matching(identifier: "ic arrowleft").element(boundBy: 1)
        icArrowleftButton.tap()
        icArrowleftButton.tap()
        icArrowleftButton.tap()
        
        let icArrowleftButton2 = element.children(matching: .button).matching(identifier: "ic arrowleft").element(boundBy: 0)
        icArrowleftButton2.tap()
        icArrowleftButton2.tap()
        icArrowleftButton2.tap()
        icArrowleftButton2.tap()
        icArrowleftButton2.tap()
                
    }
    
    func testDetailsOfValidCard() {
        
        app.scrollViews.otherElements.buttons["DETAILS"].tap()
        app.navigationBars["probafeladat.DetailsTableView"].buttons["Back"].tap()
    
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
