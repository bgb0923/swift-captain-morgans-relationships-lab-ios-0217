//
//  swift_captain_morgans_relationships_labTests.swift
//  swift-captain-morgans-relationships-labTests
//
//  Created by Johann Kerr on 1/5/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import XCTest
@testable import swift_captain_morgans_relationships_lab

class swift_captain_morgans_relationships_labTests: XCTestCase {
    
    
    var store: DataStore!
    override func setUp() {
        super.setUp()
        
        store = DataStore.sharedInstance
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        store = nil
        super.tearDown()
    }
    

    
    
    
    func testCreatePirateShipEngine() {
        let context = store.persistentContainer.viewContext
        let pirate = Pirate(context: context)
        pirate.name = "Johann"
        
        let ship = Ship(context: context)
        ship.name = "Flatiron Adventure"
        
        let engine = Engine(context: context)
        engine.engineType  = "sail"
        
        ship.engine = engine
        pirate.addToShips(ship)
        
        
        
        store.saveContext()
        store.fetchData()
        
        XCTAssertTrue(store.pirates.contains(pirate))
        let ships = pirate.ships?.allObjects as! [Ship]
        XCTAssertTrue(ships.contains(ship))
        
        XCTAssertTrue(ship.engine?.engineType == "sail")
        
        
        
    }
    
    
    func testFetchData() {
        store.fetchData()
        XCTAssertTrue(self.store.pirates.count > 0)
        for pirate in self.store.pirates {
            XCTAssertTrue((pirate.ships?.count)! > 0)
            let ships = pirate.ships?.allObjects as! [Ship]
            for ship in ships {
                
                XCTAssertTrue(ship.engine != nil)
            }
        }
        
    }
}


