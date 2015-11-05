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

    var coreDataStack = CoreDataHelper(stackType: .SQLite)
    var pickedPlace: GMSPlace?
    var placesClient: GMSPlacesClient?
    var currrentTrip: Trip?
    var predications: [NSAttributedString]?
    let regularFont = UIFont.systemFontOfSize(UIFont.labelFontSize())
    let boldFont = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
    
    
    @IBOutlet weak var tableView: UITableView!
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
        placesClient = GMSPlacesClient()
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
//MARK: MapViewDelegate
extension AddWayViewController: MKMapViewDelegate {
    
    func resetMap(coordinate: CLLocationCoordinate2D, name: String){
        mapLatitude = coordinate.latitude
        mapLongitude = coordinate.longitude
        mapLatDelta = 0.1
        mapLongDelta = 0.1
        mapSpan = MKCoordinateSpanMake(mapLatDelta!, mapLongDelta!)
        mapLocation = CLLocationCoordinate2DMake(mapLatitude!, mapLongitude!)
        mapRegion = MKCoordinateRegionMake(mapLocation!, mapSpan!)
        mapView.setRegion(mapRegion!, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        mapView.addAnnotation(annotation)
        
    }
    
}

//MARK: TableView
extension AddWayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let predications = predications{
            return predications.count
        }else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "placeCell")
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textLabel?.attributedText = predications![indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //TODO: Update selected place
    }
}

//MARK: SearchBar
extension AddWayViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if NSString(string: searchText).length > 0 {
            placeAutocomplete(searchBar.text!)
        }else{
            self.predications = []
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func placeAutocomplete(searchText: String) {
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.Region
        placesClient?.autocompleteQuery(searchText, bounds: nil, filter: filter, callback: { (results, error: NSError?) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            self.predications = []
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    let bolded = result.attributedFullText.mutableCopy() as! NSMutableAttributedString
                    bolded.enumerateAttribute(kGMSAutocompleteMatchAttribute, inRange: NSMakeRange(0, bolded.length), options: []) { (value, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                        let font = (value == nil) ? self.regularFont : self.boldFont
                        bolded.addAttribute(NSFontAttributeName, value: font, range: range)
                    }
                    
                    self.predications?.append(bolded)
                }
            }
            self.tableView.reloadData()
        })
    }
}
