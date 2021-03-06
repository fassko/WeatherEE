//
//  AppDelegate.swift
//  WeatherEE
//
//  Created by Kristaps Grinbergs on 24/03/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var coordinator: MainCoordinator?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let navController = UINavigationController()
    coordinator = MainCoordinator(navigationController: navController)
    coordinator?.start()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    return true
  }
}
