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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    @IBAction func unwindToTripDetails(segue: UIStoryboardSegue) {
        
    }
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
