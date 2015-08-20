//
//  CustomCell.swift
//  WhoIsExample
//
//  Created by Nathan Larson on 8/19/15.
//  Copyright (c) 2015 Nathan Larson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CustomCell: UITableViewCell {
    
    // This is set in cellforrowatindexpath
    var currentState:String!
    
    // The outlets on the cell
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    
    @IBOutlet weak var officeOutlet: UIButton!
    @IBOutlet weak var websiteOutlet: UIButton!
    @IBOutlet weak var phoneOutlet: UIButton!
    
    // Open in maps with directions to the office location
    @IBAction func officeAction(sender: UIButton) {
        
        var address = "\(sender.currentTitle!), \(self.currentState), USA"
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                var placemark = MKPlacemark(placemark: placemark)
                var mapItem = MKMapItem(placemark: placemark)
                var item = MKMapItem(placemark: placemark)
                item.name = "\(sender.currentTitle!)"
                let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey)

                item.openInMapsWithLaunchOptions(launchOptions as [NSObject : AnyObject])
            }
        })
    }
    
    // Go to their website
    @IBAction func websiteAction(sender: UIButton) {
        var text:String = sender.currentTitle!
        var url:NSURL = NSURL(string: text)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    // Call them
    @IBAction func phoneAction(sender: UIButton) {
        var url:NSURL = NSURL(string: "tel://\(sender.tag)")!
        UIApplication.sharedApplication().openURL(url)
    }
}
