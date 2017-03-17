//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by William Brancato on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var ships = [Ship]()
    var pirates = [Pirate]()
    var engines = [Engine]()
    
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let shipRequest: NSFetchRequest<Ship> = Ship.fetchRequest()
        let pirateRequest: NSFetchRequest<Pirate> = Pirate.fetchRequest()
        let engineRequest: NSFetchRequest<Engine> = Engine.fetchRequest()
        
        do {
            ships = try context.fetch(shipRequest)
            pirates = try context.fetch(pirateRequest)
            engines = try context.fetch(engineRequest)
        }
        catch {
            print("Something went wrong, figure out what")
        }
    }
    
    func generateTestData() {
        
        let context = persistentContainer.viewContext
        let sail = Engine(context: context)
        sail.engineType = "sail"
        let nuclear = Engine(context: context)
        nuclear.engineType = "nuclear"
        let oars = Engine(context: context)
        oars.engineType = "oars"
        let gas = Engine(context: context)
        gas.engineType = "gas"
        
        var engines = [sail, oars,gas, nuclear]
    
        for num in 1...20 {
            let pirate = Pirate(context: context)
            pirate.name = "Pirate #\(num)"
            for num in 1...10 {
                
                let ship = Ship(context: context)
                ship.name = "Ship #\(num)"
                ship.engine = engines[Int(arc4random_uniform(3))]
                pirate.addToShips(ship)
            }
            self.saveContext()
        }
        self.fetchData()
    }
    
    func addPirateToShip(pirate: Pirate, ship: Ship) {
        ship.pirate = pirate
        pirate.addToShips(ship)
    }
    
    func addEngineToShip(engine: Engine, ship: Ship ) {
        
        ship.engine = engine
        engine.addToShips(ship)
        
    }
}
