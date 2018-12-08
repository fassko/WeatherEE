//
//  Station.swift
//  WeatherEE
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation

import SWXMLHash

struct Station {
  let name: String
  let wmocode: String?
  let longitude: Double
  let latitude: Double
  let phenomenon: String?
  let visibility: String?
  let precipitations: String?
  let airpressure: String?
  let relativehumidity: String?
  let airtemperature: String?
  let winddirection: String?
  let windspeed: String?
  let windspeedmax: String?
  let waterlevel: String?
  let watertemperature: String?
  let uvindex: String?
  
  var parameters: [Parameter] {
    let parameters = [
      Parameter(name: "Air temperature (°C)", value: airtemperature),
      Parameter(name: "Wind speed (m/s)", value: windspeed),
      Parameter(name: "Wind direction", value: windDirectionFromDegrees(winddirection)),
      Parameter(name: "Air pressure", value: airpressure),
      Parameter(name: "Precipitations", value: precipitations),
      Parameter(name: "UV index", value: uvindex),
      Parameter(name: "Visibility", value: visibility),
      Parameter(name: "Relative humidity", value: relativehumidity)
    ]
    
    return parameters.compactMap({
      guard let value = $0.value, !value.isEmpty else {
        return nil
      }
      
      return $0
    }).map({ return $0 })
  }
  
  // swiftlint:disable cyclomatic_complexity
  private func windDirectionFromDegrees(_ degrees: String?) -> String? {
    guard let stringDegrees = degrees, let degrees = Double(stringDegrees) else {
      return nil
    }
    
    var windDirection: String = ""
    
    if 348.75 <= degrees, degrees <= 360 {
      windDirection = "N"
    } else if 0 <= degrees, degrees <= 11.25 {
      windDirection = "N"
    } else if 11.25 < degrees, degrees <= 33.75 {
      windDirection = "NNE"
    } else if 33.75 < degrees, degrees <= 56.25 {
      windDirection = "NE"
    } else if 56.25 < degrees, degrees <= 78.75 {
      windDirection = "ENE"
    } else if 78.75 < degrees, degrees <= 101.25 {
      windDirection = "E"
    } else if 101.25 < degrees, degrees <= 123.75 {
      windDirection = "ESE"
    } else if 123.75 < degrees, degrees <= 146.25 {
      windDirection = "SE"
    } else if 146.25 < degrees, degrees <= 168.75 {
      windDirection = "SSE"
    } else if 168.75 < degrees, degrees <= 191.25 {
      windDirection = "S"
    } else if 191.25 < degrees, degrees <= 213.75 {
      windDirection = "SSW"
    } else if 213.75 < degrees, degrees <= 236.25 {
      windDirection = "SW"
    } else if 236.25 < degrees, degrees <= 258.75 {
      windDirection = "WSW"
    } else if 258.75 < degrees, degrees <= 281.25 {
      windDirection = "W"
    } else if 281.25 < degrees, degrees <= 303.75 {
      windDirection = "WNW"
    } else if 303.75 < degrees, degrees <= 326.25 {
      windDirection = "NW"
    } else if 326.25 < degrees, degrees < 348.75 {
      windDirection = "NNW"
    }
    
    return windDirection
  }
}

extension Station: XMLIndexerDeserializable {
  
  static func deserialize(_ node: XMLIndexer) throws -> Station {
    return try Station(
      name: node["name"].value(),
      wmocode: node["wmocode"].value(),
      longitude: node["longitude"].value(),
      latitude: node["latitude"].value(),
      phenomenon: node["phenomenon"].value(),
      visibility: node["visibility"].value(),
      precipitations: node["precipitations"].value(),
      airpressure: node["airpressure"].value(),
      relativehumidity: node["relativehumidity"].value(),
      airtemperature: node["airtemperature"].value(),
      winddirection: node["winddirection"].value(),
      windspeed: node["windspeed"].value(),
      windspeedmax: node["windspeedmax"].value(),
      waterlevel: node["waterlevel"].value(),
      watertemperature: node["watertemperature"].value(),
      uvindex: node["uvindex"].value()
    )
  }
}
