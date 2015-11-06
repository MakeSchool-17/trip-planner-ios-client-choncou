//
//  GetStartedViewController.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/26/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    var passedTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nav = navBar{
            nav.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            nav.shadowImage = UIImage()
            nav.translucent = true
            if let currentTrip = passedTrip{
                nav.topItem?.title = currentTrip.name
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let currentTrip = passedTrip{
            //TODO: Exit the VC
            if currentTrip.waypoints?.count > 0{
                dismissViewControllerAnimated(false, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    @IBAction func unwindToTripDetails(segue: UIStoryboardSegue) {
    
    }
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GetStartedToAdd" {
            if let vc = segue.destinationViewController as? AddWayViewController {
                vc.currentTrip = passedTrip
            }
        }
    }


}
