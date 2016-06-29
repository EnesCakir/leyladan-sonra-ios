//
//  UIColorExtensions.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/15/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit


extension UIColor
{
    // MARK: - Theme based colors
    class func primaryColor() -> UIColor
    {
        return UIColor(red: 51/255, green: 153/255, blue: 153/255, alpha: 1.0)
    }
    
    class func primaryDarkColor() -> UIColor
    {
        return UIColor(red: 0/255, green: 69/255, blue: 73/255, alpha: 1.0)
    }
    
    class func primaryShadowColor() -> UIColor
    {
        return UIColor(red: 21/255, green: 100/255, blue: 100/255, alpha: 1.0)
    }
    
    class func lightGreyColor() -> UIColor
    {
        return UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    }
    
    class func darkGreyColor() -> UIColor
    {
        return UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    }
}