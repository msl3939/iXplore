//
//  MapViewController.swift
//  iXplore
//
//  Created by Michelle Lee on 7/11/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    func newEntryButtonPressed(sender:UIBarButtonItem) {
        let viewcontroller = NewEntryViewController (nibName: "NewEntryViewController", bundle: nil)
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add values to entry
        EntryController.sharedInstance.getEntries()

        // Do any additional setup after loading the view.
        navigationItem.title = "iXplore"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.newEntryButtonPressed(_:)))
        //let cLButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(self.findMeButton(_:)))
        
        navigationItem.rightBarButtonItem = addButton
        //navigationItem.leftBarButtonItem = cLButton
        
        // Set delegate
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self
        
        let location = CLLocationCoordinate2D(latitude: -34, longitude: 18.5)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //Add pins
        mapView.addAnnotations(EntryController.sharedInstance.entries)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()


    }

    override func viewDidAppear(animated: Bool) {
        mapView.addAnnotations(EntryController.sharedInstance.getEntries())
        tableView.reloadData()
        
    }
    
    //Change pins & add callouts
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if (annotation.isKindOfClass(MKUserLocation)){
            return nil
        }
        
        if (annotationView == nil){
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = UIColor.purpleColor()
            
            annotationView!.canShowCallout = true
        }
        
        annotationView!.annotation = annotation
        return annotationView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return EntryController.sharedInstance.entries.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cellIdentifier")
        }
        
        cell!.textLabel?.text = String(EntryController.sharedInstance.entries[indexPath.row].title!)
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = CLLocationCoordinate2D(latitude: EntryController.sharedInstance.entries[indexPath.row].coordinate.latitude, longitude: EntryController.sharedInstance.entries[indexPath.row].coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(EntryController.sharedInstance.entries[indexPath.row], animated: true)
    }
    
  /*  func findMeButton(sender: UIButton) {
        //Current location
        locationManager.requestWhenInUseAuthorization()
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .NotDetermined:
            locationManager.requestAlwaysAuthorization()
            
        case .Restricted, .Denied:
            
            let alertController = UIAlertController(
                title: "I'm Sad :(",
                message: "I hate my life",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
