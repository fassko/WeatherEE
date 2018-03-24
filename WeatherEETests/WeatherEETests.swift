//
//  WeatherEETests.swift
//  WeatherEETests
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import XCTest

class WeatherEETests: XCTestCase {
  
  let weatherService: WeatherService
  
  override func setUp() {
    super.setUp()
    
    weatherService = WeatherService()
  }
  
  func testData() {
    weatherService.getStationsData()
  }
  
}
