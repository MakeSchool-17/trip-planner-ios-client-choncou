//
//  AddTripViewController.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/26/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import UIKit
import CoreData

class AddTripViewController: UIViewController, UITextFieldDelegate {
    
    var appDel: AppDelegate?
    
    @IBOutlet weak var txtTripTitle: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.translucent = true
        
        txtTripTitle.delegate = self

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        txtTripTitle.resignFirstResponder()
        
        return true
    }

    @IBAction func btnAddTrip(sender: UIBarButtonItem) {
        
        if let newTripTitle = txtTripTitle.text{
            print(newTripTitle)
            
            //TODO: Add newTripTitle to list
            
        txtTripTitle.text = ""
        txtTripTitle.endEditing(true)
        
    }

    
    //MARK: - Navigation
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
