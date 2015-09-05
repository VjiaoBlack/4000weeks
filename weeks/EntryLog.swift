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
        return mobc().executeFetchRequest(fetchRequest, error: &e) as! [Entry]

    }
    
    class func fetch(aroundDate: NSDate) -> [Entry] {
        let fetchRequest = NSFetchRequest(entityName: "Entry")
        fetchRequest.predicate = NSPredicate(format: "date BETWEEN %@", [aroundDate.zeroSecond(), aroundDate.lastSecond()])
        var e: NSError?
        return mobc().executeFetchRequest(fetchRequest, error: &e) as! [Entry]
    }
    
    
    // Always save context after modifying
    class func insertNew() -> Entry {
        let entry = NSEntityDescription.insertNewObjectForEntityForName("Entry",
            inManagedObjectContext: mobc()) as! Entry
        return entry
    }
    
    func deleteAndSave() {
        Entry.mobc().deleteObject(self)
        Entry.saveContext()
    }
    
    class func saveContext() {
        var err: NSError?
        mobc().save(&err)
    }
    
    override var description: String {
       return "\(date): \(title)\n\t\(summary)"
    }
}