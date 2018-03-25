//
//  WeatherEEUITests.swift
//  WeatherEEUITests
//
//  Created by Kristaps Grinbergs on 25/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import XCTest

class WeatherEEUITests: XCTestCase {
  
  /// Screenshot counter
  var counter = 0
  
  let observationName = "Ruhnu"
  
  let app = XCUIApplication()
  
  override func setUp() {
    super.setUp()
    
    setupSnapshot(app)
    app.launch()
    
    continueAfterFailure = false
  }
  
  func testAppRun() {
    sleep(5)
    
    takeScreenShot("MainScreen")
    
    let predicate = NSPredicate(format: "label BEGINSWITH '\(observationName)'")
    let annotation = app.otherElements.matching(predicate).element(boundBy: 0)
    
    XCTAssertTrue(waitForElementToAppear(annotation, timeout: 10))
    
    annotation.tap()
    
    let moreInfoButton = app.buttons["More Info"]
    XCTAssertTrue(waitForElementToAppear(moreInfoButton))
    
    takeScreenShot("Tap_Observation")
    
    moreInfoButton.tap()
    
    let navigationBar = app.navigationBars[observationName]
    XCTAssertTrue(waitForElementToAppear(navigationBar))
    
    takeScreenShot("Observation_Data")
 
    let parametersTable = app.tables.firstMatch
    let temperatureCell = parametersTable.cells.staticTexts["Air temperature (°C)"]
    let windSpeedCell = parametersTable.cells.staticTexts["Wind speed (m/s)"]
    let windDirectionCell = parametersTable.cells.staticTexts["Wind direction"]
    
    XCTAssertTrue(waitForElementToAppear(temperatureCell))
    XCTAssertTrue(waitForElementToAppear(windSpeedCell))
    XCTAssertTrue(waitForElementToAppear(windDirectionCell))
    
    let backButton = navigationBar.buttons["Observations"].firstMatch
    backButton.tap()
    
    let observationsNavigationbar = app.navigationBars["Observations"].firstMatch
    XCTAssertTrue(waitForElementToAppear(observationsNavigationbar))
    
    let refreshButton = observationsNavigationbar.buttons["Refresh"]
    XCTAssertTrue(waitForElementToAppear(refreshButton))
    
    refreshButton.tap()
    
    sleep(3)
  }
  
  private func takeScreenShot(_ name: String) {
    snapshot("\(String(format: "%02d", counter))_\(name)")
    counter += 1
  }
  
}
