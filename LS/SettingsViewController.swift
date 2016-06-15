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
        // Do any additional setup after loading the view.
    }

    func setupInfos(){
        if let volunteer = Constants.UserDefaults.objectForKey("volunteer"){
            firstnameTF.text = volunteer["first_name"] as? String
            lastnameTF.text = volunteer["last_name"] as? String
            emailTF.text = volunteer["email"] as? String
            mobileTF.text = volunteer["mobile"] as? String
            cityTF.text = volunteer["city"] as? String
        }
    }
    
    func setupSwitch() {
        notifSwitch.onColor = UIColor.primaryColor();
        notifSwitch.offColor = UIColor.cloudsColor();
        notifSwitch.onBackgroundColor = UIColor(red: 210/255, green: 240/255, blue: 240/255, alpha: 1);
        notifSwitch.offBackgroundColor = UIColor.silverColor();
        notifSwitch.offLabel.font = UIFont.boldFlatFontOfSize(14);
        notifSwitch.onLabel.font = UIFont.boldFlatFontOfSize(14);
        notifSwitch.onLabel.text = "Açık"
        notifSwitch.offLabel.text = "Kapalı"
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
    
    func textFieldDidEndEditing(textField: UITextField) {
        Constants.UserDefaults.setObject([
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
    
    @IBAction func openEnesCakir(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://enescakir.com")!)
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
