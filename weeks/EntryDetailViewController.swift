//
//  EntryDetailViewController.swift
//  weeks
//
//  Created by Victor Jiao on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation

class EntryDetailViewController : UIViewController {
    
    @IBOutlet weak var entry: UITextField!
    var name: String = ""
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "doneSegue" {
            name = entry.text
        }
    }
    
    
}