//
//  BaseViewController.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/15/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import MBProgressHUD
import NVActivityIndicatorView
import SwiftyJSON
import FlatUIKit

class BaseViewController: UIViewController {

    var isKeyboardShow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FormViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FormViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

    }
    func showHUD(text:String){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.CustomView
        let indicator = NVActivityIndicatorView(frame: CGRect(origin:CGPoint(x: 0, y:0), size: CGSize(width: 60, height: 60)), type: .BallScaleRippleMultiple)
        indicator.startAnimation()
        hud.customView = indicator
        hud.labelText = text
    }
    
    func hideHUD(){
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        isKeyboardShow = true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        isKeyboardShow = false
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func getAlert(title:String, message:String) -> FUIAlertView{
        let alertView = FUIAlertView()
        alertView.alertContainer.layer.cornerRadius = 6
        alertView.title = title
        alertView.message = message
        alertView.addButtonWithTitle("Tamam")
        alertView.titleLabel.textColor = UIColor.cloudsColor()
        alertView.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        alertView.messageLabel.textColor = UIColor.cloudsColor()
        alertView.messageLabel.font = UIFont.flatFontOfSize(14)
        alertView.backgroundOverlay.backgroundColor = UIColor.cloudsColor().colorWithAlphaComponent(0.8)
        alertView.alertContainer.backgroundColor = UIColor.primaryColor()
        alertView.defaultButtonColor = UIColor.cloudsColor()
        alertView.defaultButtonShadowColor = UIColor.asbestosColor()
        alertView.defaultButtonFont = UIFont.boldFlatFontOfSize(16)
        alertView.defaultButtonTitleColor = UIColor.asbestosColor()
        return alertView
    }


}
