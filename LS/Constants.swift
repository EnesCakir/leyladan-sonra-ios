//
//  Constant.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import Foundation
import UIKit

class Constants
{
    static let UserDefaults = Foundation.UserDefaults.standard
    
    struct URL {
        static let Base = "http://www.leyladansonra.com"
        static let API = "http://www.leyladansonra.com/api"
        static let Uploads = "http://www.leyladansonra.com/resources/admin/uploads"
        static func Child(_ imageUrl:String) -> String { return "http://www.leyladansonra.com/resources/admin/uploads/child_photos/\(imageUrl)" }
        static func Faculty(_ imageUrl:String) -> String { return "http://www.leyladansonra.com/resources/admin/uploads/faculty_logos/\(imageUrl).png" }
    }
}
