//
//  ViewController.swift
//  WeatherEE
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var mapView: MKMapView!

  let weatherService = WeatherService()
  
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let centerCoordinate = CLLocationCoordinate2D(latitude: 58.5953, longitude: 25.0136)
    let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 200000, longitudinalMeters: 500000)
    mapView.setRegion(region, animated: false)
    
    loadObservations()
    
    uiTest()
  }
  
  /**
   Load observations
   */
  private func loadObservations() {
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
  
  @IBAction func refreshObservations(_ sender: Any) {
    self.mapView.removeAnnotations(self.mapView.annotations)
    loadObservations()
  }
}

extension MapViewController: MKMapViewDelegate {
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
    
    view.markerTintColor = #colorLiteral(red: 0.2235294118, green: 0.3098039216, blue: 0.5294117647, alpha: 1)
    view.displayPriority = .required
    
    return view
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    
    if let annotation = view.annotation as? StationAnnotation {
      coordinator?.showObservationStation(annotation.station)
    }
    
    mapView.deselectAnnotation(view.annotation, animated: true)
  }
}

extension MapViewController {
  func uiTest() {
    if CommandLine.arguments.contains("-launchObservationStation") {
      let station = Station(name: "Ruhnu",
                            wmocode: "26227",
                            longitude: 23.258883333206178,
                            latitude: 57.783394444110783,
                            phenomenon: nil,
                            visibility: "12.0",
                            precipitations: "0",
                            airpressure: "992.4",
                            relativehumidity: "93",
                            airtemperature: "5.2",
                            winddirection: "210",
                            windspeed: "7.2",
                            windspeedmax: "10.5",
                            waterlevel: "17",
                            watertemperature: "4.9",
                            uvindex: nil)
      coordinator?.showObservationStation(station)
    }
  }
}
