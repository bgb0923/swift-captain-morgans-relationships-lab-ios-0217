//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by William Brancato on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class ShipDetailViewController: UIViewController {
    
    @IBOutlet weak var shipLabel: UILabel!
    
    @IBOutlet weak var pirateLabel: UILabel!
    
    @IBOutlet weak var propulsionLabel: UILabel!
    
    override func viewDidLoad() {
        self.shipLabel.text = self.ship.name
        self.pirateLabel.text = self.ship.pirate?.name
        self.propulsionLabel.text = self.ship.engine?.engineType
    }
    
    var ship: Ship!
    
}
