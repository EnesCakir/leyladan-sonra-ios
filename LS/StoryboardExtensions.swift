
//
//  StoryboardExtensions.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/15/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

extension UIStoryboard
{
    class func childrenViewController() -> ChildrenViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let childrenVC = storyboard.instantiateViewController(withIdentifier: "ChildrenViewController") as! ChildrenViewController
        return childrenVC
    }
    
    class func detailViewController() -> DetailViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        return detailVC
    }

    class func formViewController() -> FormViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let formVC = storyboard.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        return formVC
    }

    class func leylaViewController() -> LeylaViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let leylaVC = storyboard.instantiateViewController(withIdentifier: "LeylaViewController") as! LeylaViewController
        return leylaVC
    }

    class func usViewController() -> UsViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let usVC = storyboard.instantiateViewController(withIdentifier: "UsViewController") as! UsViewController
        return usVC
    }

    class func settingsViewController() -> SettingsViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        return settingsVC
    }


}
