//
//  UIColorExtensions.swift
//  NeKaldi
//
//  Created by Mustafa Enes Cakir on 4/3/16.
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

    class func accentBlueColor() -> UIColor
    {
        return UIColor(red: 150/255, green: 215/255, blue: 233/255, alpha: 1.0)
    }
    
    class func accentOrangeColor() -> UIColor
    {
        return UIColor(red: 251/255, green: 178/255, blue: 86/255, alpha: 1.0)
    }
    
    class func primaryDarkColor() -> UIColor
    {
        return UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0)
    }
}