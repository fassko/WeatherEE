//
//  ViewController.swift
//  WeatherEE
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!

  let weatherService = WeatherService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let centerCoordinate = CLLocationCoordinate2D(latitude: 58.5953, longitude: 25.0136)
    let region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 200000, 500000)
    mapView.setRegion(region, animated: false)
    
    loadObservations()
  }
  
  /**
   Load observations
   */
  fileprivate func loadObservations() {
    weatherService.getStationsData { result in
      switch result {
      case let .success(stations):
        let annotations = stations.map({ station -> StationAnnotation in
          let annotation = StationAnnotation(station: station)
          annotation.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
          annotation.title = station.name
          annotation.subtitle = station.airtemperature
          annotation.accessibilityLabel = station.name
          annotation.accessibilityIdentifier = station.name
          
          return annotation
        })
        
        DispatchQueue.main.async {
          self.mapView.addAnnotations(annotations)
        }
        
      case let .failure(error):
        print(error)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "station", let station = sender as? Station,
      let stationViewController = segue.destination as? StationViewController {
      stationViewController.station = station
    }
  }
  
  @IBAction func refreshObservations(_ sender: Any) {
    self.mapView.removeAnnotations(self.mapView.annotations)
    loadObservations()
  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.animatesWhenAdded = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    
    view.displayPriority = .required
    
    return view
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    
    if let station = view.annotation as? StationAnnotation {
      performSegue(withIdentifier: "station", sender: station.station)
      mapView.deselectAnnotation(view.annotation, animated: true)
    }
  }
}


