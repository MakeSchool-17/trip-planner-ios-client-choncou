//
//  SyncInformation+CoreDataProperties.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/29/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SyncInformation {

    @NSManaged var lastSyncTimeStamp: NSDate?
    @NSManaged var unsyncedDeletedTrips: String?

}
