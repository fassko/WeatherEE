//
//  WeatherService.swift
//  WeatherEE
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation
import SWXMLHash

struct WeatherService {
  
  func getStationsData(_ completion: @escaping (Result<[Station]>) -> Void) {
    let url = URL(string: "http://www.ilmateenistus.ee/ilma_andmed/xml/observations.php")!
    URLSession.shared.dataTask(with: url) { data, _, error in
      do {
        if let error = error {
          print("Error \(error)")
          completion(.failure(error))
        } else if let data = data {
          print("Success")
          
          let xml = SWXMLHash.lazy(data)
          
          let stations: [Station] = try xml["observations"]["station"].value().filter {
            guard let temperature = $0.airtemperature else {
              return false
            }
            
            return !temperature.isEmpty
          }
          
          completion(.success(stations))
        }
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
