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
      Parameter(name: "Air temperature", value: airtemperature),
      Parameter(name: "Wind speed", value: windspeed),
      Parameter(name: "Wind direction", value: winddirection),
      Parameter(name: "Precipitations", value: precipitations),
      Parameter(name: "Air pressure", value: airpressure),
      Parameter(name: "UV index", value: uvindex)
    ]
    
    return parameters.flatMap({
      guard let value = $0.value, !value.isEmpty else {
        return nil
      }
      
      return $0
    }).map({ return $0 })
    
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
