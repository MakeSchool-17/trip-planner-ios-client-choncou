//
//  AddWayViewController.swift
//  Trip Planner
//
//  Created by Unathi Chonco on 10/26/15.
//  Copyright © 2015 Unathi Chonco. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class AddWayViewController: UIViewController {

    var placePicker: GMSPlacePicker?
    var coreDataStack = CoreDataHelper(stackType: .SQLite)
    var pickedPlace: GMSPlace?
    var currrentTrip: Trip?
    
    
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var mapLatitude:CLLocationDegrees?
    var mapLongitude:CLLocationDegrees?
    var mapLatDelta:CLLocationDegrees?
    var mapLongDelta:CLLocationDegrees?
    var mapSpan:MKCoordinateSpan?
    var mapLocation:CLLocationCoordinate2D?
    var mapRegion:MKCoordinateRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        // Do any additional setup after loading the view.
        print(currrentTrip)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonSave(sender: UIBarButtonItem) {
        let way = Waypoint(context: coreDataStack.managedObjectContext)
        way.name = pickedPlace?.name
        way.latitude = String(pickedPlace?.coordinate.latitude)
        way.longitude = String(pickedPlace?.coordinate.longitude)
        
        if let currrentTrip = currrentTrip {
            if CoreDataClient(managedObjectContext: coreDataStack.managedObjectContext).addWaypoint(way, trip: (currrentTrip.name!)) {
                print("Added")
                dismissViewControllerAnimated(true, completion: nil)
            }else {
                print("Failed to add Waypoint")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddWayViewController: MKMapViewDelegate {
    
    func setUpMap() {
        /*
        //Attribution: https://developers.google.com/places/ios-api/placepicker
        */
        let center = CLLocationCoordinate2DMake(51.5108396, -0.0922251)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.05, center.longitude + 0.05)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.05, center.longitude - 0.05)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                self.resetMap(place.coordinate, name: place.name)
                self.pickedPlace = place
            } else {
                print("No place selected")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }
    func resetMap(coordinate: CLLocationCoordinate2D, name: String){
        mapLatitude = coordinate.latitude
        mapLongitude = coordinate.longitude
        mapLatDelta = 0.1
        mapLongDelta = 0.1
        mapSpan = MKCoordinateSpanMake(mapLatDelta!, mapLongDelta!)
        mapLocation = CLLocationCoordinate2DMake(mapLatitude!, mapLongitude!)
        mapRegion = MKCoordinateRegionMake(mapLocation!, mapSpan!)
        mapView.setRegion(mapRegion!, animated: true)
        labelPlaceName.text = name
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        mapView.addAnnotation(annotation)
        
    }
    
}
