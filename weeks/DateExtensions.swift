//
//  DateExtensions.swift
//  weeks
//
//  Created by Will on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation

extension NSDate {
    func zeroSecond() -> NSDate {
        return dateWithTime(hours: 0, minutes: 0, seconds: 0)
    }
    
    func lastSecond() -> NSDate {
        return dateWithTime(hours: 23, minutes: 59, seconds: 59)
    }
    
    func dateWithTime(#hours: Int, minutes: Int, seconds: Int) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        let units = (NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit)
        let dateComponents = cal.components(units, fromDate: self)
        
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = seconds
        
        return cal.dateFromComponents(dateComponents)!
    }
}