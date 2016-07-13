//
//  Entry.swift
//  iXplore
//
//  Created by Michelle Lee on 7/11/16.
//  Copyright © 2016 Michelle Lee. All rights reserved.
//

import Foundation
import MapKit

class Entry: NSObject, MKAnnotation, NSCoding {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var date: String?
    var notes: String?
    
    init(title:String, coordinate:CLLocationCoordinate2D, notes:String) {
        self.title = title
        self.coordinate = coordinate
        self.date = ""
        self.notes = notes
    }
    
    
    required init?(coder: NSCoder) {
        title = (coder.decodeObjectForKey("title") as? String ?? "")
        coordinate = CLLocationCoordinate2D(latitude: (coder.decodeObjectForKey("latitude") as? CLLocationDegrees ?? CLLocationDegrees()), longitude: (coder.decodeObjectForKey("longitude") as? CLLocationDegrees ?? CLLocationDegrees()))
        date = (coder.decodeObjectForKey("date") as? String ?? "")
        notes = (coder.decodeObjectForKey("notes") as? String ?? "")
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(title, forKey: "title")
        coder.encodeObject(coordinate.latitude, forKey: "latitude")
        coder.encodeObject(coordinate.longitude, forKey: "longitude")
        coder.encodeObject(date, forKey: "date")
        coder.encodeObject(notes, forKey: "notes")
    }
 
    func returnURL() -> NSURL {
        let manager = NSFileManager.defaultManager()
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) [0]
        let fileURL: NSURL = documents.URLByAppendingPathComponent("file.txt") //<--- this is a url
        return fileURL
    }
    
}


