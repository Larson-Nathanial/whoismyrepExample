//
//  RepInfoView.swift
//  WhoIsExample
//
//  Created by Nathan Larson on 8/19/15.
//  Copyright (c) 2015 Nathan Larson. All rights reserved.
//

import UIKit

class RepInfo: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // This is the passed in state abbreviation from ViewController
    var stateAbbr:String!
    var dictionary = [:]
    // These two arrays will contain the objects returned by the API.
    var repsArray: [NSDictionary] = []
    var sensArray: [NSDictionary] = []
    
    // This is the tableview and a cover/loading view.
    @IBOutlet var tableView: UITableView!
    @IBOutlet var coverView: UIView!

    // Register my custom cell and set the seperator style to none.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    // Once the view appears, then make the call to the api.
    override func viewDidAppear(animated: Bool) {
        self.getRepAndSenatorData(self.stateAbbr)
    }

    // How many rows are in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.sensArray.count
        }else {
            return self.repsArray.count
        }
    }
    
    // The custom height of the cell (the same as the nib)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 279.0;
    }
    
    // The number of sections in the tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    // The titles for the headers in each section
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Senators"
        }else {
            return "Representatives"
        }
    }
    
    // Set the values for the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomCell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        if (indexPath.section == 0) {
            self.dictionary = self.sensArray[indexPath.row] as NSDictionary
        }else {
            self.dictionary = self.repsArray[indexPath.row] as NSDictionary
        }
        cell.nameLabel!.text = dictionary.valueForKey("name") as? String
        cell.districtLabel!.text = dictionary.valueForKey("district") as? String
        cell.partyLabel!.text = dictionary.valueForKey("party") as? String
        cell.officeOutlet.setTitle(dictionary.valueForKey("office") as? String, forState: UIControlState.Normal)
        cell.websiteOutlet.setTitle(dictionary.valueForKey("link") as? String, forState: UIControlState.Normal)
        cell.currentState = self.stateAbbr!
        var phone = dictionary.valueForKey("phone") as? String
        phone = phone?.stringByReplacingOccurrencesOfString("-", withString: "")
        cell.phoneOutlet.setTitle(dictionary.valueForKey("phone") as? String, forState: UIControlState.Normal)
        let number:Int? = phone?.toInt()
        cell.phoneOutlet.tag = number!
        
        return cell
    }
    
    // Get the information from the api
    func getRepAndSenatorData(stateAbbr:String) {
        
        let senatorURL = NSURL(string: "http://whoismyrepresentative.com/getall_sens_bystate.php?state=\(stateAbbr)&output=json");
        let data = NSData(contentsOfURL: senatorURL!)
        
        let repsURL = NSURL(string: "http://whoismyrepresentative.com/getall_reps_bystate.php?state=\(stateAbbr)&output=json")
        let repData = NSData(contentsOfURL: repsURL!)
        
        if (data == nil || repData == nil) {
            
            let alertController = UIAlertController(title: "No Internet", message: "This application requires internet connectivity to operate.  Please turn on wifi or ensure you have cell reception and data and try again.", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
        }else {
            
            let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
            
            let repJsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(repData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
            if let item = jsonObject as? NSDictionary {
                if let person = item["results"] as? NSArray {
                    for obj in person  {
                        self.sensArray.append(obj as! NSDictionary)
                    }
                }
            }
            
            if let item = repJsonObject as? NSDictionary {
                if let person = item["results"] as? NSArray {
                    for obj in person  {
                        self.repsArray.append(obj as! NSDictionary)
                    }
                }
            }
            self.tableView.reloadData()
            UIView.animateWithDuration(0.3, animations: {
                self.coverView.alpha = 0.0
            })
            
        }
        
    }
    
}
