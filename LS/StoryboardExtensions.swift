
//
//  StoryboardExtensions.swift
//  NeKaldi
//
//  Created by Mustafa Enes Cakir on 4/3/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//
import UIKit

extension UIStoryboard
{
    class func childrenViewController() -> ChildrenViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let childrenVC = storyboard.instantiateViewControllerWithIdentifier("ChildrenViewController") as! ChildrenViewController
        return childrenVC
    }
    
    class func detailViewController() -> DetailViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        return detailVC
    }

    class func formViewController() -> FormViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let formVC = storyboard.instantiateViewControllerWithIdentifier("FormViewController") as! FormViewController
        return formVC
    }

    class func leylaViewController() -> LeylaViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let leylaVC = storyboard.instantiateViewControllerWithIdentifier("LeylaViewController") as! LeylaViewController
        return leylaVC
    }

    class func usViewController() -> UsViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let usVC = storyboard.instantiateViewControllerWithIdentifier("UsViewController") as! UsViewController
        return usVC
    }

    class func settingsViewController() -> SettingsViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        return settingsVC
    }

    class func mediaViewController() -> MediaViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mediaVC = storyboard.instantiateViewControllerWithIdentifier("MediaViewController") as! MediaViewController
        return mediaVC
    }


}