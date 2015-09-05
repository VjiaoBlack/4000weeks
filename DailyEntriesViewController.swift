//
//  DailyEntriesViewController.swift
//  weeks
//
//  Created by Victor Jiao on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation

class DailyEntriesViewController : UITableViewController {
    // 
    
    var data = ["one","two","three"]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("entry") as! UITableViewCell
        let i = indexPath.row
        cell.textLabel?.text = data[i]
        println("\(i)")
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        var entryDeet = segue.sourceViewController as! EntryDetailViewController
        var entry = entryDeet.name
        
        data.append(entry)
        
    }


    
}