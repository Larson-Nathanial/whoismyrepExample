//
//  ViewController.swift
//  WhoIsExample
//
//  Created by Nathan Larson on 8/19/15.
//  Copyright (c) 2015 Nathan Larson. All rights reserved.
//

import UIKit

// This is the root view controller on the Main.storyboard.
// It also is the datasource and delegate for the tableview
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlet connection for the tableview on the storyboard.
    @IBOutlet var tableView: UITableView!
    
    // These are passed individually to the RepInfoView so that information can be pulled based upon the state.
    // These are not displayed to the user.
    var items: [String] = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]
    
    // These are displayed to the user on the tableview.
    var stateNames: [String] = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    // Only register a tableview cell here.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // The number of rows in the in the tableview.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    // Get's a dequed cell, sets the state name and accessory type.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = self.stateNames[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    // When selected, instantiate the RepInfoView Controller and pass the abbreviated state, then push the view.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var viewController = self.storyboard!.instantiateViewControllerWithIdentifier("repView") as! RepInfo
        viewController.stateAbbr = self.items[indexPath.row]
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    
}

