//
//  ViewController.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/20/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    var selectedTrip: Trip?
    
    var trips: [Trip] = []
    var coreDataStack = CoreDataHelper(stackType: .SQLite)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.translucent = true
        
        //TODO: Initialize data for table
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        trips = CoreDataClient(managedObjectContext: coreDataStack.managedObjectContext).allTrips()
        
        tableView.reloadData()
    }
    
    //MARK: Navigation
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ViewWaySeg" {
            let nextViewController = segue.destinationViewController as! TripDetailsViewController
            nextViewController.passedTrip = selectedTrip!
        }
        if segue.identifier == "GetStartedSeg" {
            let nextViewController = segue.destinationViewController as! GetStartedViewController
            nextViewController.passedTrip = selectedTrip!
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (trips.count)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textLabel?.text = trips[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        selectedTrip = trips[indexPath.row]
        if trips[indexPath.row].waypoints?.count > 0{
            self.performSegueWithIdentifier("ViewWaySeg", sender: tableView)
        }else {
            self.performSegueWithIdentifier("GetStartedSeg", sender: tableView)

        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            if CoreDataClient(managedObjectContext: coreDataStack.managedObjectContext).deleteTrip(trips[indexPath.row].name!){
                trips = CoreDataClient(managedObjectContext: coreDataStack.managedObjectContext).allTrips()
                tableView.reloadData()

            }
            
        }
    }
    
}

