//
//  Entry.swift
//  
//
//  Created by Will on 9/4/15.
//
//

import Foundation
import CoreData

class Entry: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var picture: NSData
    @NSManaged var title: String
    @NSManaged var summary: String

}
