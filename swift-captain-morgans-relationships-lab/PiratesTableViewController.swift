//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by William Brancato on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class PiratesTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        self.store.fetchData()
        if self.store.pirates.isEmpty || self.store.ships.isEmpty {
            self.store.generateTestData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.pirates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pirateCell", for: indexPath)
        cell.textLabel?.text = self.store.pirates[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ShipsTableViewController {
         dest.pirate = self.store.pirates[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}
