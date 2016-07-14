//
//  EntryController.swift
//  iXplore
//
//  Created by Michelle Lee on 7/11/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import Foundation
import MapKit

class EntryController: NSObject {
    static var sharedInstance = EntryController()
    
    var entries:[Entry] = []
    
    func returnURL() -> NSURL {
        let manager = NSFileManager.defaultManager()
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) [0]
        let fileURL: NSURL = documents.URLByAppendingPathComponent("file.txt") //<--- this is a url
        return fileURL
    }
    
    func getEntries() -> [Entry] {
        if let entry =
            NSKeyedUnarchiver.unarchiveObjectWithFile(returnURL().path!) as? [Entry] {
                entries = entry
            }
        return entries
    }
    
    
    /* func spotList() {
        
        let spot = Entry(title: "spot1", coordinate: CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983), date: NSDate(), notes: "1")
        let spot2 = Entry(title: "spot2", coordinate: CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045), date: NSDate(), notes: "2")
        let spot3 = Entry(title: "spot3", coordinate: CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055), date: NSDate(), notes: "3")
        
        entries = [spot,spot2, spot3]
    } */

}