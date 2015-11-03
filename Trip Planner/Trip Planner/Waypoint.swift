//
//  Waypoint.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/29/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import Foundation
import CoreData


class Waypoint: NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("Waypoint", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }
    
//    convenience init(context: NSManagedObjectContext, jsonWaypoint: JSONWaypoint) {
//        let entityDescription = NSEntityDescription.entityForName("Waypoint", inManagedObjectContext:
//            context)!
//        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
//        
//        name = jsonWaypoint.name
//        latitude = jsonWaypoint.latitude
//        longitude = jsonWaypoint.longitude
//    }

}
