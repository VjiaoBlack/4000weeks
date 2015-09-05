//
//  EntryHandler.swift
//  
//
//  Created by Will on 9/5/15.
//
//

import Foundation
import CoreData

extension Entry {
    
    class func mobc() -> NSManagedObjectContext {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext!
    }
    
    class func fetch(limit: Int = 0) -> [Entry] {
        let fetchRequest = NSFetchRequest(entityName: "Entry")
        fetchRequest.fetchLimit = limit
        var e: NSError?
        let entities = mobc().executeFetchRequest(fetchRequest, error: &e) as! [Entry]
        return entities
    }
    
    
    // Always save context after modifying
    class func insert() -> Entry {
        let entry = NSEntityDescription.insertNewObjectForEntityForName("Entry",
            inManagedObjectContext: mobc()) as! Entry
        return entry
    }
    
    class func saveContext() {
        var err: NSError?
        mobc().save(&err)
    }
    
    
}