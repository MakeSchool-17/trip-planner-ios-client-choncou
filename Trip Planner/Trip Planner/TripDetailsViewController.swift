//
//  TripDetailsViewController.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/26/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import UIKit

class TripDetailsViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelDestination: UILabel!
    var passedTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nav = navBar{
            nav.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            nav.shadowImage = UIImage()
            nav.translucent = true
            if let currentTrip = passedTrip{
                nav.topItem?.title = currentTrip.name
                //TODO: set labelDestination
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let tableView = tableView {
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAddWaypoints(sender: UIButton) {
        performSegueWithIdentifier("TripDetailsToAddWay", sender: sender)
    }

    
    // MARK: - Navigation
    @IBAction func unwindToTripDetails(segue: UIStoryboardSegue) {
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.title == "Add Waypoints"{
            let nextSeg = segue.destinationViewController as! AddWayViewController
            nextSeg.currentTrip = passedTrip
        }
    }

}

extension TripDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let currentTrip = passedTrip{
            return (currentTrip.waypoints?.count)!
        }else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textLabel?.text = "TODO: Put real waypoints"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //TODO: View Waypoint Details
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            //TODO: Delete waypoint
            
        }
    }
    
}
