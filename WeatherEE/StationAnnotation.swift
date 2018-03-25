//
//  StationAnnotation.swift
//  WeatherEE
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation
import MapKit

class StationAnnotation: MKPointAnnotation, UIAccessibilityIdentification {
  /// Accesibility identifier
  var accessibilityIdentifier: String?
  
  let station: Station
  
  init(station: Station) {
    self.station = station
    
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
