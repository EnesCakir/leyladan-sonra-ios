//
//  NSDateExtensions.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/15/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import Foundation

extension NSDate
{
    class func dateToNSDate(date:String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(name: "Europe/Istanbul")
        formatter.locale = NSLocale(localeIdentifier: "tr_TR")
        return formatter.dateFromString(date)!
    }
    
    
    func toLabel() -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.timeZone = NSTimeZone(name: "Europe/Istanbul")
        formatter.locale = NSLocale(localeIdentifier: "tr_TR")
        return formatter.stringFromDate(self)
    }
}