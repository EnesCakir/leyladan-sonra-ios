//
//  NSDateExtensions.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/15/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import Foundation

extension Date
{
    static func dateToNSDate(_ date:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Europe/Istanbul")
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.date(from: date)!
    }
    
    
    func toLabel() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.timeZone = TimeZone(identifier: "Europe/Istanbul")
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: self)
    }
}
