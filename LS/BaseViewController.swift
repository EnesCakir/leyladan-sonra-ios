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
        
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    func showHUD(_ text:String){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.mode = MBProgressHUDMode.customView
        let indicator = NVActivityIndicatorView(frame: CGRect(origin:CGPoint(x: 0, y:0), size: CGSize(width: 60, height: 60)), type: .ballScaleRippleMultiple)
      
        indicator.startAnimating()
        hud?.customView = indicator
        hud?.labelText = text
    }
    
    func hideHUD(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        isKeyboardShow = true
    }
    
    func keyboardWillHide(_ notification: Notification) {
        isKeyboardShow = false
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func getAlert(_ title:String, message:String) -> FUIAlertView{
        let alertView = FUIAlertView()
        alertView.alertContainer.layer.cornerRadius = 6
        alertView.title = title
        alertView.message = message
        alertView.addButton(withTitle: "Tamam")
        alertView.titleLabel.textColor = UIColor.clouds()
        alertView.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        alertView.messageLabel.textColor = UIColor.clouds()
        alertView.messageLabel.font = UIFont.flatFont(ofSize: 14)
        alertView.backgroundOverlay.backgroundColor = UIColor.clouds().withAlphaComponent(0.8)
        alertView.alertContainer.backgroundColor = UIColor.primaryColor()
        alertView.defaultButtonColor = UIColor.clouds()
        alertView.defaultButtonShadowColor = UIColor.asbestos()
        alertView.defaultButtonFont = UIFont.boldFlatFont(ofSize: 16)
        alertView.defaultButtonTitleColor = UIColor.asbestos()
        return alertView
    }


}
