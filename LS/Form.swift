//
//  Form.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

class Form {
    
    // MARK: - Properties
    var first_name:String
    var last_name:String
    var email:String
    var mobile:String
    var city:String
    var message:String
    
    // MARK: - Computed Properties
    
    
    init(first_name:String, last_name:String, email:String, mobile:String, city:String, message:String){
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.mobile = mobile
        self.city = city
        self.message = message
    }
    
    func printForm() {
        print("New Form")
        print("Sender: \(first_name) \(last_name)")
        print("E-mail:\(email)  Phone: \(mobile)")
        print("City:\(city)")
        print("Message:")
        print(message)
    }
    
    func send(childId:Int){
//        let parameters = [
//            "id": String(100000),
//            "first_name": first_name,
//            "last_name": last_name,
//            "email": email,
//            "mobile": mobile,
//            "city": city,
//            "text": message
//        ]
//        
//        Alamofire.request(.POST, Constants.BaseURL + "/child/form", parameters: parameters).response { request, response, data, error in
//            switch response!.statusCode {
//            case 404:
//                let alertController = UIAlertController(title: "iOScreator", message: "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//                self.presentViewController(alertController, animated: true, completion: nil)
//            case 500:
//                let alertController = UIAlertController(title: "iOScreator", message: "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//                self.presentViewController(alertController, animated: true, completion: nil)
//
//            case 200:
//                let alertController = UIAlertController(title: "iOScreator", message: "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//                self.presentViewController(alertController, animated: true, completion: nil)
//            }
//            
//            let alertController = UIAlertController(title: "iOScreator", message: "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//            
//            self.presentViewController(alertController, animated: true, completion: nil)
//
//            print("response")
//            print(response)
//            print("data")
//            print(data)
//            print("error")
//            print(error)
//        }
        
    }

}
