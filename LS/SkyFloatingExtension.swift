//
//  SkyExtensions.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/15/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    func paintPrimary(){
        self.tintColor = UIColor.primaryColor()
        self.textColor = UIColor.darkGreyColor()
        self.lineColor = UIColor.lightGreyColor()
        self.selectedTitleColor = UIColor.primaryColor()
        self.selectedLineColor = UIColor.primaryColor()
        
        self.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    
    func showError(text:String? = "Boş Bırakılamaz", animationCompletion: (())? = nil) {
        self.errorMessage = text
        self.setTitleVisible(true, animated: true)
        self.highlighted = true
    }
    
    func hideError() {
        self.setTitleVisible(false, animated: true)
        self.errorMessage = ""
        self.highlighted = false
    }

}
