//
//  NewEntryViewController.swift
//  iXplore
//
//  Created by Michelle Lee on 7/12/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import UIKit
import CoreLocation

class NewEntryViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var dateText: UITextField!
    
    @IBOutlet weak var latitudeText: UITextField!
    
    @IBOutlet weak var longitudeText: UITextField!
    
    @IBOutlet weak var notesText: UITextField!
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        
        let newEntry: Entry
        
        if (latitudeText.text != "" && longitudeText.text != "") {
        
        newEntry = Entry(title: (titleText.text)!, coordinate: CLLocationCoordinate2D(latitude: Double(latitudeText.text!)!, longitude: Double(longitudeText.text!)!), notes: (notesText.text)!)
        }
        else {
             newEntry = Entry(title: titleText.text!, coordinate: CLLocationCoordinate2D(latitude: -34, longitude: 18.5), notes: notesText.text!)
        }
        
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateValue = dateFormatter.stringFromDate(NSDate())
        
        newEntry.date = dateValue
        
        EntryController.sharedInstance.entries.append(newEntry)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
