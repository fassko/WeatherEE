//
//  MainCoordinator.swift
//  MeteoLV
//
//  Created by Kristaps Grinbergs on 28/10/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import Foundation

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let observationsViewController = MapViewController.instantiate()
    observationsViewController.coordinator = self
    navigationController.pushViewController(observationsViewController, animated: false)
  }
  
  func showObservationStation(_ station: Station) {
    let stationViewController = StationViewController.instantiate()
    stationViewController.station = station
    navigationController.pushViewController(stationViewController, animated: true)
  }
}
