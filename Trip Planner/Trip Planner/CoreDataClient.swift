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
    
    func getTrip(trip: Trip) -> Trip {
        let trips = managedObjectContext.objectWithID(trip.objectID)
        
        return trips as! Trip
    }
    
    func addtrip(name: String) -> Bool {
        let newTrip = Trip(context: managedObjectContext)
        newTrip.name = name
        
        do{
            try managedObjectContext.save()
            return true
            
        }catch{
            return false
        }
        
    }
    
    func deleteTrip(trip: Trip) -> Bool {

        let trip = managedObjectContext.objectWithID(trip.objectID)
        
        managedObjectContext.deleteObject(trip)
        
        do{
            try managedObjectContext.save()
            return true
            
        }catch{
            return false
        }
    }
    
    func addWaypoint(waypoint: Waypoint, trip: Trip) -> Bool{
        waypoint.trip = self.getTrip(trip)
        
        do{
            try managedObjectContext.save()
            return true
            
        }catch{
            return false
        }
    }
    
    func deleteWaypoint(way: Waypoint) -> Bool {
        
        let trip = managedObjectContext.objectWithID(way.objectID)
        
        managedObjectContext.deleteObject(trip)
        
        do{
            try managedObjectContext.save()
            return true
            
        }catch{
            return false
        }
    }
    
    func returnWays(trip: Trip) -> [Waypoint]{
        let fetchRequest = NSFetchRequest(entityName: "Waypoint")
        fetchRequest.predicate =  NSPredicate(format: "trip = %@", trip)
        fetchRequest.returnsObjectsAsFaults = false
        
        let ways = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [Waypoint]
        
        return ways
    }
    
}