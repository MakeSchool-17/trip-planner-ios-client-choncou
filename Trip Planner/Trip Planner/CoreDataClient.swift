//
//  CoreDataClient.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 11/2/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import Foundation
import CoreData

class CoreDataClient {
    
    var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func allTrips() -> [Trip] {
        let fetchRequest = NSFetchRequest(entityName: "Trip")
        let trips = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [Trip]
        
        return trips
    }
    
    func getTrip(name: String) -> Trip {
        let request = NSFetchRequest(entityName: "Trip")
        request.predicate = NSPredicate(format: "name = %@", name)
        request.returnsObjectsAsFaults = false
        
        let trips = try! managedObjectContext.executeFetchRequest(request) as! [Trip]
        
        return trips[0]
    }
    
    func addtrip(name: String) -> Bool {
        let newTrip = NSEntityDescription.insertNewObjectForEntityForName("Trip", inManagedObjectContext: managedObjectContext)
        newTrip.setValue(name, forKey: "name")
        
        do{
            try managedObjectContext.save()
            return true
            
        }catch{
            return false
        }
        
    }
    
    func deleteTrip(name:String) -> Bool {
        let request = NSFetchRequest(entityName: "Trip")
        request.predicate = NSPredicate(format: "name = %@", name)
        request.returnsObjectsAsFaults = false
        
        let trip = try! managedObjectContext.executeFetchRequest(request) as! [Trip]
        
        managedObjectContext.deleteObject(trip[0])
        
        do{
            try managedObjectContext.save()
            return true
            
        }catch{
            return false
        }
    }
    
}