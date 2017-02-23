//
//  SettingsViewController.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/13/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FlatUIKit
import OneSignal
class SettingsViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var firstnameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastnameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    @IBOutlet weak var notifSwitch: FUISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setupInfos()
        setupTextFields()
        setupSwitch()
        setupTap()
        self.navigationItem.title = "Ayarlar"

        // Do any additional setup after loading the view.
    }

    func setupInfos(){
        if let v = Constants.UserDefaults.object(forKey: "volunteer"){
          if let volunteer = v as? NSDictionary {
            firstnameTF.text = volunteer["first_name"] as? String
            lastnameTF.text = volunteer["last_name"] as? String
            emailTF.text = volunteer["email"] as? String
            mobileTF.text = volunteer["mobile"] as? String
            cityTF.text = volunteer["city"] as? String
          }
        }
    }
    
    func setupSwitch() {
        notifSwitch.onColor = UIColor.white;
        notifSwitch.offColor = UIColor.clouds();
        notifSwitch.onBackgroundColor = UIColor.primaryColor();
        notifSwitch.offBackgroundColor = UIColor.silver();
        notifSwitch.offLabel.font = UIFont.boldFlatFont(ofSize: 14);
        notifSwitch.onLabel.font = UIFont.boldFlatFont(ofSize: 14);
        notifSwitch.onLabel.text = "Açık"
        notifSwitch.offLabel.text = "Kapalı"
      
      OneSignal.idsAvailable({ (userId, pushToken) in
        if (pushToken != nil) {
          self.notifSwitch.isOn = true
        }
        else {
          self.notifSwitch.isOn = false
        }
      })
    }

    
    func setupTextFields() {
        firstnameTF.paintPrimary()
        lastnameTF.paintPrimary()
        emailTF.paintPrimary()
        mobileTF.paintPrimary()
        cityTF.paintPrimary()
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Constants.UserDefaults.set([
            "first_name": firstnameTF.text!,
            "last_name": lastnameTF.text!,
            "email": emailTF.text!,
            "mobile": mobileTF.text!,
            "city": cityTF.text!], forKey: "volunteer")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openEnesCakir(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "http://enescakir.com")!)
    }
    
    @IBAction func openFolx(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "http://folx.com.tr")!)
    }


    @IBAction func pushNotificationValueChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
          OneSignal.setSubscription(true)
          OneSignal.registerForPushNotifications()
          print("opened")
//            UserDefaults.standard.removeObject(forKey: "token")
//            let pushNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(pushNotificationSettings)
//            UIApplication.shared.registerForRemoteNotifications()


        }
            
        else
        {
          OneSignal.setSubscription(false)
          print("removed")
//            UIApplication.shared.unregisterForRemoteNotifications()
//            UserDefaults.standard.removeObject(forKey: "token")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
