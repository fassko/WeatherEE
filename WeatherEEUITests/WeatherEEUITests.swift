//
//  WeatherEEUITests.swift
//  WeatherEEUITests
//
//  Created by Kristaps Grinbergs on 25/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import XCTest

class WeatherEEUITests: XCTestCase {
  
  let observationName = "Ruhnu"
  
  private var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    
    app = XCUIApplication()
    setupSnapshot(app)
    
    continueAfterFailure = false
  }
  
  func testAppRun() {
    app.launch()
    
    takeScreenShot("MainScreen", counter: 1)
    
    let predicate = NSPredicate(format: "label BEGINSWITH '\(observationName)'")
    let annotation = app.otherElements.matching(predicate).element(boundBy: 0)
    
    XCTAssertTrue(waitForElementToAppear(annotation, timeout: 10))
    
    annotation.tap()
    
    takeScreenShot("Tapped_Observation_Station", counter: 2)
  }
  
  func testObservationStation() {
    
    app.launchArguments.append("-launchObservationStation")
    app.launch()
    
    let navigationBar = app.navigationBars["Ruhnu"]
    XCTAssertTrue(waitForElementToAppear(navigationBar))
    
    let table = app.tables.firstMatch
    
    waitForElementToAppear(table.searchCell("Air temperature (°C)"))
    waitForElementToAppear(table.searchCell("5.2"))
    
    waitForElementToAppear(table.searchCell("Wind speed (m/s)"))
    waitForElementToAppear(table.searchCell("7.2"))
    
    waitForElementToAppear(table.searchCell("Wind direction"))
    waitForElementToAppear(table.searchCell("SSW"))
    
    waitForElementToAppear(table.searchCell("Air pressure"))
    waitForElementToAppear(table.searchCell("992.4"))
    
    waitForElementToAppear(table.searchCell("Precipitations"))
    waitForElementToAppear(table.searchCell("0"))
    
    waitForElementToAppear(table.searchCell("Visibility"))
    waitForElementToAppear(table.searchCell("12.0"))
    
    waitForElementToAppear(table.searchCell("Relative humidity"))
    waitForElementToAppear(table.searchCell("93"))
    
    takeScreenShot("Ruhnu_station", counter: 3)
    
    let backButton = navigationBar.buttons["Observations"]
    backButton.tap()
  }
  
  private func takeScreenShot(_ name: String, counter: Int) {
    snapshot("\(String(format: "%02d", counter))_\(name)")
  }
  
  private func launchApp() {
    sleep(5)
    app.launch()
  }
  
}
