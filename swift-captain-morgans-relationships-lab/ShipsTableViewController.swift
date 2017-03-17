//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by William Brancato on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class ShipsTableViewController: UITableViewController {
    
    var pirate: Pirate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pirate!.ships!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell", for: indexPath)
        let ships = Array(self.pirate!.ships!)
        cell.textLabel?.text = (ships[indexPath.row] as AnyObject).name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ShipDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let ships  = Array(self.pirate!.ships!)
            if let ship = ships[indexPath.row] as? Ship {
                dest.ship = ship
            }
        }
    }
}
