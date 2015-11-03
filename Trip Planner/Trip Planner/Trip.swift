//
//  Trip.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/29/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import Foundation
import CoreData


class Trip: NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }
    
//    convenience init(context: NSManagedObjectContext, jsonTrip: JSONTrip) {
//        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext:
//            context)!
//        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
//        
//        name = jsonTrip.tripName
//        serverID = jsonTrip.serverID
//    }

}
