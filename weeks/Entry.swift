//
//  Entry.swift
//  weeks
//
//  Created by Will on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation
import CoreData

class Entry: NSManagedObject {

    @NSManaged var date: NSTimeInterval
    @NSManaged var picture: NSData
    @NSManaged var summary: String
    @NSManaged var title: String

}
