//
//  StationViewController.swift
//  MeteoLV
//
//  Created by Kristaps Grinbergs on 18/02/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import UIKit

class StationViewController: UITableViewController, Storyboarded {

  /// Observation station
  var station: Station!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = station.name
  }
}

// MARK: - Table view controller
extension StationViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return station.parameters.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath)

    let parameter = station.parameters[indexPath.row]
    cell.textLabel?.text = parameter.name
    cell.detailTextLabel?.text = parameter.value
    
    return cell
  }
}
